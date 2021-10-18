Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B6FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A00E60F44
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A00E60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E66EA8D;
	Mon, 18 Oct 2021 23:02:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99BD6EA8D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFZc0vUSfjTXADOv0YwRf9BR1alFr4eTSy5ttF2K4Iw0jjpjTcAoXxrEigPJYEeiiTGdPpXMTCGxnBf8U/6n+h6cTE8bzxQ/sP50mTh+vRe3X4yAPvueUXis1lWjhAqQFayfXnrmM6+gWSkWbCZow5vnGcY26WA+Iaa3hl/h+lJUIQ49mRyzN20qE/TSDGa/6Jqr84EcEFxV1Twg5iD46YG1mnCg8OoRLLLjnF9MZ2oNK9dHsbhKX9rQuwTJDX9LKZkpPPDVH/r5jPh4mxlvb4agLgVoyhk9H3MYh3yccLg12Y8fUgzlodxGo2itkpgGv443SwQx1LCzn0Hz1Fi4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2zCtdqwa4C8VppzME0KP3tI6jTwqqZhW5acgcl0ADw=;
 b=mcs4ALNT89bD/hlrgNf5jfPa5f+oTKmM9j0I2aNxfYNTMFmmlS3x2uxwNfuCtwCuRk5cNbjT6CO8c7OoD2GHalwUWIPfdy7C42H+Mu7Wc0wjQ2Frk6Z3JRupkWUTQcIQVBntQ5S67rxQiCBdLkt6aWcmub0IiN1z/WhVjsnnzGmUvSBKeRtNUfvN0AO71I4sy4Whl2nce3YO1StKYMeDgRtO3GxRGnfveNLiyns3mdZh8Ufy5rXBQxsSwMT2ayLbp1dtTkT0EzzuH1Yv9MXNzgAUtwF9F3lwNSsjiFSAsaRllS/9zaZBKnLpJFghEo5CvZ8G84NKdo9W0Wr4RBkdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2zCtdqwa4C8VppzME0KP3tI6jTwqqZhW5acgcl0ADw=;
 b=YIdonUBUb4cAlgUSCd/iqhFyBd012H1nRHMUz6A5H80PzKJJpr8T7t1Ma+tk7XmXK03VxHIkZur6xqkq3iP1uE97/lyxvrO1OLdemWWoh7cvh5e2o3NgeEWzo9g31eZZoVjg3RS8B86UnBqidmep21oN6H6dZyQBXyfrBCXvIRM=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4677.namprd12.prod.outlook.com (2603:10b6:4:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 23:02:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 23:02:34 +0000
Message-ID: <e2b793d0-d7df-ad02-c239-a0165c4f9abc@amd.com>
Date: Mon, 18 Oct 2021 19:02:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/5] drm/amd/pm: Slight function rename
Content-Language: en-CA
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <20211013031042.53540-2-luben.tuikov@amd.com>
 <580a9f54-1cbc-27b0-f5d8-05db2180b69a@molgen.mpg.de>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <580a9f54-1cbc-27b0-f5d8-05db2180b69a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::11) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.32.170] (165.204.84.11) by
 YT3PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Mon, 18 Oct 2021 23:02:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f88b6618-6278-4493-4344-08d9928b5f29
X-MS-TrafficTypeDiagnostic: DM5PR12MB4677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4677DCD0507BB7AFBB3404DD99BC9@DM5PR12MB4677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/3XsTidpUyGzm+nd/kvaZMz9IFOQW3Sz9qqt5QyFOnXbn7YUG1+PZJnT6tJqvKbgcAmw9wY+W63SlfckSApGhIOi17m6+GpYIBmiPD8vVTRc1ZSsBIhLlR2S8iq6P9epBnWIaUgzJShrkOBNNgLc2XzbWaGVGLNh7Ev9KyE5IYv6PzV+F5CcZ9hKfMEHzNg4SNkVITzo37XQagHKLqtDXJpt/6KEOOvmUkbeK/fH3QjvD7zIWwWOKwIzQnME3e3DWclBik7ovrHigWHz08PgRMtLuc8sJpnsAc7SjTFCSfJ8Icb4OoE5R+AvOjz50xchS2V2v71oR3ixvE58M4oP9j5rTzUiEH22j1J6457A4zULZm2f37nOJQ1R4zltjMG0BKkembFJaXmAiVdkLB0ArY1TxQkPjIxpiNu9XFxMZ1hYNSUQwlLIT7Jejb1JwBgu/JTJohgktMfH5jxWtLBLBhJSRew+HooLnEkkyjHectSMWwHLe8oVR8hbDNA3WUVWI9p+Z7qYqx+zVsme+CnXxl5VqxUp2elQDJmk/n3zP0xkEcUeoAWMtD7qB7IbyIOgDysatXPqUO2fkTAFiHZDwei6CCYjDa2Bh2PgFLO1nDHFPoqUChAmLAtMi2xzRZdvayOacuaU5DMEYcXeQNnvYafN3Wlo9W0M/Ajcx8rHP16VfLnnlDplQBWpil/4FSQ6GoCiWwvaAsImevpZNckpXvFf2GaIeeS8VorqH2q4s513U4FZvrGQF4j4oQlqHvX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6486002)(86362001)(508600001)(53546011)(38100700002)(4326008)(5660300002)(31686004)(16576012)(66946007)(66556008)(2906002)(66476007)(26005)(6916009)(4744005)(186003)(44832011)(83380400001)(2616005)(8676002)(956004)(36756003)(316002)(31696002)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEtlK2c4b3JxSmNTbk0rMXpiQVZNb3dsVllqTUFrU0EybExJNm1rN21NM2JY?=
 =?utf-8?B?NmZSRkhzQzZ4VWZlb1JPcE9zV1NaUlRWRUdyby9TdlQydnhseWxzQmZQSDRt?=
 =?utf-8?B?K0tKMU8ySzZORnJQYWthZEl0L3ZEdGcxZzlsdGlkTnpOWk9pa2NCMnlEUnNM?=
 =?utf-8?B?Zis4c1dFYXJBNFNxcjVHamlFU2dJSVpVVG8vODhad2RZU0dqc0xCcjZranhB?=
 =?utf-8?B?UzQ1U3V3Z1MxdkRlbFhPSHVXY0w1NTVpY0UxQUxienJoL3Y0TWM3WmYxckFh?=
 =?utf-8?B?TlYwTXo5bTR5bEIrbEJTOXc4SEIxU1JhTEZhajNxQlI0Z1JCbXFNODFKUmRy?=
 =?utf-8?B?QjlMYVdqOVAzOUJ4WmVKNlpxS2lLTUFYZXM3NUp0UFk2bE5KbnhsOHM0QzJY?=
 =?utf-8?B?SGZ0U2Z2ZHhLY0JmZUNBRGFHeDI1SzlFcEt2Ly9hbGU4aWp4ZFJPcXErRGpL?=
 =?utf-8?B?d3UzajFaVGVqOWNLZ3ZZZjFPbHhyQXM1UFZrbkI3dDU5YWtYWDUvZVpXRGVj?=
 =?utf-8?B?bms5eHg1UUFOREpkcGpDUlhMVkw5YVA5bVU0WHFmblc3UThZeEh5NWMvYU5l?=
 =?utf-8?B?WEp5aTg0MjJGMzNBaTY3c3hFd3lpLzJSNCtlYjAzME4zWm1qSGZrQ1hUMVBT?=
 =?utf-8?B?MXNFNGVZdzNwWmlwN1d6RkFtblJJclBWSlpIWGd5Y3plby9EVWdKbnlQVkcw?=
 =?utf-8?B?M3JOakpWQzZ6eTgxMzQ1S1VBZ3BzL2tjRGErUWFEa1grbDVPdFhtb3krNENC?=
 =?utf-8?B?TmpLS3hsYjNsSXE2ZFF6T1l5REJ3QnhuTlliaDVWK1lhZDBWVCt4ZjRDYnM0?=
 =?utf-8?B?Mk5xcG9SVTJpTWNyQzJrcTFvbk8wUDd1d08wZU1lZzJsTXRKaUJaSzJ4VWR1?=
 =?utf-8?B?a2pBTTRIK0FUZWpicDA1YThod1FMTEkrTFFXY1lSeTh3cGZwSHRFaHJtNWNU?=
 =?utf-8?B?VWdqQUJlZnpPUER1Z0dLSlV2RTFyNVE5VitxQVJSdUdLUmFxZCtxbGFxWVBK?=
 =?utf-8?B?RmN5bWU0cVplWXB3WU5PV1BxOW1adERYcXNnejh1SFk3VUJGT2MyUjVmNS8w?=
 =?utf-8?B?YW0zTGx6Z0I1cFloYy9za1ZuVndWNHJQMnNoTEMvYXVzMi9DRDJpVTlaN010?=
 =?utf-8?B?LzlNSlVUZnM3OEp5clVUclp6Y1JzM2ZHc0R5SmhxQy9KOUxUQk4zZjRQKzAx?=
 =?utf-8?B?am9JcXY2NFZMSWhBb0hEN25VdzNDWmxhbzQ2azNzWElheGVaY0pXNnl3cXpJ?=
 =?utf-8?B?SUowWG4wWkNFbCtvNC8xUU15bmQycFVNb0ptRzFha25PQzNFU0JEUGtCT2tL?=
 =?utf-8?B?SXJDWC9ZUFZuUEc2cGpNRXk4OUovblJVNzgrMHBTRjkwS09kYlFPWms5ekxN?=
 =?utf-8?B?anhtSTVMbnFBcE5rU2wvZmU0aDd3clR4ZVpBTnk3RFlQS3BzRXJYQk5qNjUv?=
 =?utf-8?B?L3FiYmJUQW5IRCt3d0ZjV3dnbW12UUlKNHk1bXpmbXJkVU5VMHFTVlEzRjZP?=
 =?utf-8?B?QkhTa2docmhzTDU4VC9PVlFJRDNlOWFIT0xwQ0dIaVpJWnphWHR2aWRVbXVQ?=
 =?utf-8?B?YUlONW1mRGhEUmJOc2djMnJ3NEFiN0FHM0lYUmZWT0wvMXFmT0pTV3MreTlJ?=
 =?utf-8?B?blNtK0VYVWhZWFlvSFJGbWNhWGM2eitSK3JjbWpVajNSSjVCMi8vZVllWW9Y?=
 =?utf-8?B?ZTRZYWlOcmpZZEd1SHkvNThJRVRNZmU5bzZaWDBWQWxmY1N4OTdnRGg3U3FT?=
 =?utf-8?Q?TtjDGDXpRB6BWD7T0D4DzGY/1xkFgHZcqkTYOAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b6618-6278-4493-4344-08d9928b5f29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:02:34.6353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8kqwW803q3y9oZQPYJgNW90tSgtgDjE1oW8bdaFLM24lOMYcuoNZdWwsYBtH1Ut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4677
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Okay, no problem--I'll add a verb there and resend the patch set. Thanks for letting me know.

Regards,
Luben

On 2021-10-18 18:52, Paul Menzel wrote:
> Dear Luben,
>
>
> Am 13.10.21 um 05:10 schrieb Luben Tuikov:
>
> […]
>
> A small nit regarding the subject. It’d be great if you made it a 
> statement by adding a verb (in imperative mood). git standard messages 
> are doing the same with *Merge …* and *Revert …*.
>
>
> Kind regards,
>
> Paul

