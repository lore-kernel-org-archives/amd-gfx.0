Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2ECC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E5710EEC4;
	Fri,  4 Feb 2022 17:17:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F7410EEC4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VufUvQqkPomAKtwAXc03gyDcMOpf/ZQnc67ZjV/1fnOEn7svEBUHir8vNAWI4m2juOnvBOyE8ePWJbNKxA8VYL4xDhJ6iUXI5HeZNZr0ORVEp7OoaSH+dTMG/dVPoHyHFNfMtd19mmt2gTuyFLWSWYkrCr3l/mbWd2UWYjKAGmpbzLuAePOG2wNQc7pvjg3NK9/BW6ULPDlNC011u4LDq/fbng9fqObEHnLuXMGKw22PnDNiAh3Km1twJaLKh0QOGRN2yyFRIyTwVDWP3RjSqNNG0nGwhAr61I5RW3nAmDgaqF1EbufYtHS3N9YojImS6fMdqKZRohlsIfJZhNO4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/dIM1dKHbjW5To8vkHqiaNxraJ3+WhZvgFEoQMSc2U=;
 b=b+AAzePHANc4kRHOUnZKDsctNSfT9RWGZb/J/5BxrpnvWLhoE4nthdtaqVVPxIr9I8x+McNNLI7RsqLEOT6rkwhA3UHeK1HoLtAPw03dF3g2le+GNwFC68QnPtZJFaDnuYwMBVPnxXx+knc6ljoPRernjUBdjMJVSwMELhfwUnwXpAk8D1ZqDArbfUJszTqlA0HbYc+Mul19GCZ/6gzFDpXxCZT8BSNNA4oPE/9TusKYFOlN9tD8gPF9tq6xkSHOLcZiy/LBxj5LyBLn1rabOQmVxr+WEMbR4BmzhhUq2chSkC3oXcif614UONFUIbsYKL9WAzhfTmnjNyVfKFdaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/dIM1dKHbjW5To8vkHqiaNxraJ3+WhZvgFEoQMSc2U=;
 b=AdyJW7mOyva5xBXzdQ3wQtw07kt13SEhVWYDhB4t8ZozaZupQhCYJDtFAYeX4fN2/BobOaCzjVd1e7rQG4lsv47aevnHFT66nrCQQBX+90COL9629BEt/lnbcTCyrj2w2oXxd4c0OImubepnjKmvwrRcj8/UYEvZM6TqkkUwpOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR12MB1622.namprd12.prod.outlook.com (2603:10b6:910:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 4 Feb
 2022 17:16:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:16:55 +0000
Message-ID: <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
Date: Fri, 4 Feb 2022 18:16:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:206:14::28) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68513e1b-753e-42c6-ceae-08d9e80224c4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1622:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1622748065E26240EB4BE2BFF2299@CY4PR12MB1622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eC29OyORC2i5bvrhywJ5L0+2NVCGnQHKMBowSIl6fdsmjngVUAZo1Yw0t+5lDweJ2Defy4Mw6buBocnOq7nYpk3OL5pOPc3ajLvPWwfeCDtn8zmCaHP9XSoIp6s8XnC+7iKyfiJBq8aDIK8AfnKKI1lhPoTFmMD9QLr2C9mP2ynEa/Gs2/xexVGHooGe4DdrAbw81UK7Hq0lEjhstW/DbeX/EIjcpy76Jq9BB01RLruog0XPP+aYbTI2kwATalvfiX8TjNqKji1vmONUJAvIhGuhXiSLn05njkLk2Axd9jdgnI4PZvOCLpxZAZzTjXUVb6X02XelB5wPKsGegqnpkVOmxvKRUeeVB1BjwGCNKTYtJZ1voqBAz5mGQNITGtOudBriQ0bS+gmcEY80fM3n5hQfAk+tyN7e4/I8mdIOQ+bDq0xvKYGnfMuCMOPZIrUZ+gGh6G5ItZjxJqJy7ARRg1ucCpm66JUgeWTd9CyNMhmLL986HXW0KMI2YeFDOGHems4liCgkHu2gd2EOr9T8PSAvGE30Ctn1WRh4VqvJTMFfex11YaNzwMeicNHMUTFgOmV3Lu9Sqedfdm/RlFzT2SRYf943QgQDjmXRhH9dPW/zXsOAvNbYsvuZ+kY+Pjwyj8HdLCAdl7PsdjxhgGUIQqf6Q18GFi34JK5c4djm6MMszuf7pL1mJ+pXq/fWEUOd6XLcu3C0n/DLsf/QvtTvTni5oO7TLSKzHsDVIhNy7qyFkVsu7FBpfWredW0GWlbi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(8676002)(36756003)(83380400001)(4744005)(6486002)(8936002)(66946007)(66476007)(66556008)(316002)(110136005)(54906003)(4326008)(5660300002)(38100700002)(31696002)(86362001)(2906002)(26005)(31686004)(6506007)(186003)(6512007)(6666004)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHQyaTFybVhnWkhUc2dNZEJLcHIrbnY2cEt0dldTSXVJVjE4SENTQm9FTDI1?=
 =?utf-8?B?WHZCQ1dZdG10WGVWc2JiOXdDbmhNSW80ZldzMHM1aUJBZkxXdXB1L1NhY3JT?=
 =?utf-8?B?UkFRcU9KMXREb0VnRXNPUEM1ZjUveXo0Z3Q3QzU0NW1rQ1kwVEszOFJWNXFu?=
 =?utf-8?B?UUJXNmlNVjNLN25nYlVZckJTMHVWMFNtUTlCM0l3YUozMlRncjdCbHVGTjVW?=
 =?utf-8?B?SHZ4Zzk5MElER1JwTmUycjNWc3JPY3A5OEhnYmVQMVMwTTBYS2dVaThtVFFC?=
 =?utf-8?B?U1hwZk1wYnNjQkpnb0JrVVp5djVXSENEa1hCVU94S1hESHRVaGp0Y0hmNi92?=
 =?utf-8?B?aURJaldrNlhKUmgzZ2srbVpvY3RGN202U0FNWXlqYThlbHhPTDZxTFZDekZ2?=
 =?utf-8?B?alZ0c3RtZnBudVR1TUFtQ0FNcXpESFhmMXJHVVB3V3NHT3l4NG10ZkhTSDh4?=
 =?utf-8?B?bExCdjVwaHhhVloxU09td2RTR0xqNzVVNkovMWNhNkRnT0tmalV2aFdaQk1R?=
 =?utf-8?B?azhCOWVoYlV2Vm1GOHlRSytoRDdIbHlOMm44OE5Jbm9LMkMzM2ZNU0FZNWdI?=
 =?utf-8?B?c3RBSmpMcDBxemd2dzJrTmwvODNhYUJ5a2lpZmN1NmJXeHFKY2sxVTVVNEly?=
 =?utf-8?B?VkNSMUp5WlNnVnJ0OWFJbDVtNEwybWZDR0tteXpOeTBVL1FYQXBIMmZPU1hT?=
 =?utf-8?B?Z1kwRWE2bnh2ZjlvN2oxQnUwNk1qSk8vcVRaTmFkQitmMkNBU1AyNlNZbDU3?=
 =?utf-8?B?ODRPaEJpQ3I1c3pSZE9nOVMxaURJd0RxN3pqK21PNkZzWjEwS3pzZzBENENK?=
 =?utf-8?B?WlY1OWNRQklRay93cFEzZHJvdzJya3JMakE5djU3YmZONzBESTFlU3k3U2Fz?=
 =?utf-8?B?Ni9XZnB6YmJkeUl6UzhkeGkva054YjJ4cTlMQlMra0t3VWRjeUtFTXRLcnY4?=
 =?utf-8?B?Q1Y3RGZrV0YxQ200NFFyaHY0RkdmZElhL3c5Uk5wVlFmUzl6ZkhxS2V0RDV2?=
 =?utf-8?B?eEdpWmkyS3ZvQjJhNTFYV1dvVldzNkFOU3lnYnA2NUVycDREMEtUQmlSaHc1?=
 =?utf-8?B?ZGZPSXlSMktRZmNzS3Q0QUFwbUg2WnhJb3VDSWY0T0J6L1RXMExFTXZRdE03?=
 =?utf-8?B?WFNrdzdNVTB5ejF2c25BdWRpV0RScmV0dCtQZ3poOWpNV2pZNklPYjBDeUx1?=
 =?utf-8?B?aWJPWllibjBWQjI4VHpRQVhLME1oMnZieFEyMlU1SVNqbzU3VDF0TXVaQVl3?=
 =?utf-8?B?STVhdHd5UnZJZ3BtbEpUclpIem5kR3I1SDRtSThxb0dOV0ZQdVRKSDNIT09x?=
 =?utf-8?B?RXhscFMrRVRuVXBhMXRScldnUjh1Nk1vNCtrMkRFdSt0bzFVMVFwYU9UOUxV?=
 =?utf-8?B?aCsvN0xVU0E4NjhIVlU4YWxHcmtXNUM1cEtITHJ3YndqczlPQ0dGVTUxL2tL?=
 =?utf-8?B?OFNhRnRERDJKaUJJZVV3VWdheFdlRFNzS1FXWnV3eE1CNzB5M2szVEthd0Ni?=
 =?utf-8?B?WnNGRC9iZTVKSEt4THJmbWdZNmVKT1o0MmdCMmUrVmd0QnZQbTR1Z2JwczRV?=
 =?utf-8?B?dGVEazVRTk8ySHpjcWlMY1FEeFg5Qzd1ZSt5YkkzQU9MV2l4SnVDRmh3a1dh?=
 =?utf-8?B?RXR3YVUxSEluK2QwRGJlZkE0WXdkV2xIMEYvQjZBYWxWZEFSYkxOaStVSXRp?=
 =?utf-8?B?NTJLdWNMamx3Q0tzb2w0a3IwSThjUzJjUU13bEttaHErUFEwVWJMUnIycWJ5?=
 =?utf-8?B?ZHZaeC9wRnBvcHBpRi9MVFdHWDkraTR3b0c4OHhCenJPVEdhUTMyL2FnRVVk?=
 =?utf-8?B?cTluTC9ROWhwQ08xeUVjbStqZTlHNmVrSmUvY1R1ejlVQjgyMk0veTJNc3Bi?=
 =?utf-8?B?amhERm4wdTNvaHgzV21KZ0xjWFJobDBmQkRmMnZha3oydGJkK3BMcWFtSjlo?=
 =?utf-8?B?M1lpc2s2ZDVLclFpY1FDTHNKK09sZ3JrRmVHYTFGMlVLTU9XR2NWMVl3T3V1?=
 =?utf-8?B?bWM0VlVUMVpHSmhZaS91TnExd0JFTXZxNHl5S3FRWUZaaFhBeTBtNWY2eHdt?=
 =?utf-8?B?M2NrejgzVFdWNll2cVdHNmN1QzdaekZqZEUyczFZcFJmbXEyYlFFQnU3SHNu?=
 =?utf-8?B?NUVNOVoxSHdXS3Z6MWlVS3VxdVdhSStrMHpVNUdpa0JQeUxBSmt2aFB2Y1BN?=
 =?utf-8?Q?dLlon3uzX6EQSO9jTGSjlNA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68513e1b-753e-42c6-ceae-08d9e80224c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:16:55.6123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/jmcOqWTP8mu/SfLkIxG6/XQUkY8cLP2VRSR3LtKzMKN/YrM0hi4LCtgDffSFDTNeuVpoxH0nRq50Pr4tk1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1622
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/4/2022 6:11 PM, Lazar, Lijo wrote:
> BTW, since this is already providing a set of values it would be useful to provide one more field as the reset reason - RAS error recovery, GPU hung recovery or something else.

Adding this additional parameter instead of blocking something in 
kernel, seems like a better idea. The app can filter out and read what 
it is interested into.

- Shashank
