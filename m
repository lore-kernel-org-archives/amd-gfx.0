Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04C7610E6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E04C7610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711EE6EA6D;
	Wed, 13 Oct 2021 15:27:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554496EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdXdnuHE219R+3vWHpn/mcXBpVT3CM8JuMAkgtJan11mJ6MDs9QIPHC9HUqUxI6raMJOuynHw1YRtjn/LkZE9XE7aE5Cvw3vR6YI+c0O2l6wT5efLgOhYtAiZHyJW59HaCGAoDFuS8Jb6frg1Qrq/f2DQ2CFlRMoiR5JvJ5D5vIwD91EzINW3iFz5cKZh2pApz4jA2FHYJ615ze3WBS8C9LcMOS9QLx8DgY63FuKI4tFvLDEjanlYzZovT7rFIzSnilei6Mgzm/EgVX3W6hYLJZ9827tD0hkojFUqzT2ESxtvtIOvyVC8Mvhr3+NXMjXGxrgBmnd4U4d7OyEdxfntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS8a/ztnfbikyjG0ltFPklWvxPn+10OZe/pedmAX/yA=;
 b=Yd+qQ1yT6+eOpRULayk4MisRrBEkfLJBOKyMz6DiQ5KDTG+4VLqyA9Rwl1TxpnpDE1mbOXrcz5qTui+oVtmbbNEi0yZ6sVGaaSxQ4hWLAqaPXgID1tpoOcIF6viysFyOsufgA3TIOboLpCvA3xDtRD9SY3tUqOiZgHCVoInVRia+L+Q6RnUrVkMvXRRjIo2SLsMdjHLEaTUIQsIaIU005+SsKPb65r0OSQzLY48/S33D57pocIoqcdsKZn+0/OA6wPyKrl1VIKw44TS9hiGGPROGKhVWdkCCcnSipxUSZuWfvw/APubcVka96hmcO/ExkgwxAASZHN06gdRXuLuVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS8a/ztnfbikyjG0ltFPklWvxPn+10OZe/pedmAX/yA=;
 b=J/Wu+S0To29YoZavDmSNB+lnSCthfiuq/Krx9BcbKuJVqqYYvdxEP79DyBeM7kLVcpwh6tmIjaqXTg/Rf1Oz7BuGTpJaKI5VB38fJ8TU78VVdD9AJDTIRirwYgkMq7aYNIJVEJaxLypFX8aLDMyUV6I+ZhyCoXL3o+BuSN3334w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 15:27:17 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%4]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 15:27:17 +0000
Subject: Re: [PATCH] MAINTAINERS: Add Siqueira for AMD DC
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 rodrigo.siqueira@amd.com
References: <20211008212122.230566-1-harry.wentland@amd.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <41d13501-b398-d495-70d0-fc3227a8d777@amd.com>
Date: Wed, 13 Oct 2021 11:27:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211008212122.230566-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0842.namprd03.prod.outlook.com
 (2603:10b6:408:13d::7) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:56e0:6d60:18aa:8d02:959d:80df]
 (2607:fea8:56e0:6d60:18aa:8d02:959d:80df) by
 BN9PR03CA0842.namprd03.prod.outlook.com (2603:10b6:408:13d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4734334-8b97-438d-b147-08d98e5df070
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB50596FD78C0A76E3CF097C4398B79@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlCNJYJ6CSyYNtUdZNx+4QwKLPxAD1N+i6w2tkIaY66vIU1PqyfDyAY9SfNEt35kGWDDzKOFEsjSnogcjxVPLJgfgl36RW9SaMpWsZTAe7bpRDpiMdbYwHfROt9QTkJmJuhkhPk5yPpHPVCS4pD4KFi9JEzmhntKT+6uVdfebX0Xvt1lR26MOUSwkzk0D0M8lk7Qb0u8s9DJLWE0POK1NwGfmNHkS22GszLZOjt0wRPx/9ZbsvqCJA7riO8pgvtoj8iovqaX1lFEQ3kmysJL+p4GUNTsX6KM9rL8Hy6I/gZXR8/pk99JTGvigg+XISt9S66Od7bEPyYPrzSYnU72oM+RR8x+/9eao3kRGtbl4kKy/00j/Fnx01iMnKI5ykgxl7hOUrB0TaMod4CI6bSQVxZT1GsZ176NoVJqvtFt76oT48XoaBaowJdqFxMKpNkyk1Nrb5Ic3PwjwZ+BNzA4hktn2sJvkAzXF5Ii9YWTKtTFCjXFleW+4APpj/0iu4tzs2aH5Do3CsQLQsq1IfJIQ3FjCYNiJjLMV1yAoWWDfIXir+nBS8w7VS9zY/Rsi8QzCfQqN1xYSA796rn193IeZn9T8UObiMnMaEKgXbzMPdyLO5/G72vnMwpHqOIyeo9ILwG9BZMYGNACgLeFtubq9V6IKM2QKcG6s0xdykeOORbCdFjMW7f6TFiIf7X2SLSbr1honpkkbNjOMzUNSr290uYCnsINQtyd+tycE+bVsSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(53546011)(5660300002)(8676002)(38100700002)(186003)(31686004)(31696002)(316002)(966005)(66946007)(4744005)(2616005)(2906002)(6486002)(66476007)(8936002)(36756003)(66556008)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RGSU4yNFNjWC9YZ3IzNzhuM1lUNFYvMWowWGRDdnhZTGlXdUdxbEUvVnpE?=
 =?utf-8?B?b0R0d1JTRHdodGZyMVNvVTBmcExlNTZtN0FDY2M2T3lxbWRaTXRNWXNpZmo3?=
 =?utf-8?B?K3JTQUMzL2libFpPMDdaQXJoNUpwMHQxbVpabU8wVFZ5NGtwQW1nWmdITSs2?=
 =?utf-8?B?YUpwQ3Y1WDhjeC8wY0FYUGNWMnFQdDN5R2RVb3VJQTVtQlNmcWcrWEQwaklT?=
 =?utf-8?B?Y3lCNUE5clM3YXZlaG93RUYwVFJpVFdzNlh1cHl6MzhXUzhURkh3UlljSXdH?=
 =?utf-8?B?cllvV2xrM0JmTXlCcXMrZDRrdE5COUpEdWpOT2NOVXBHbExiMFhRdWQvTEQr?=
 =?utf-8?B?L20xc3dMRjI0aEs5NzZGREVNZ2s3VDJ3a0dCUEJERmhRNDAwT0tjRVQyMy8z?=
 =?utf-8?B?RUNUTmYzS0pzRzVDRXZHdHJEKzBmRHBUWXNudkMxM2Q2WGpJYVJWVy8rYTE3?=
 =?utf-8?B?dFErYXRFWkNnRGExN3JISGEwTGZwUStvVU9DU0RsY0VYQkNZdHZXSC9IY1dn?=
 =?utf-8?B?QUYzTkVGSWN3MklDUDJCMGFYb3U3Z2xOamRKWURwcTNsY3J2RERzenFNbVd3?=
 =?utf-8?B?TU5ZUkF5ZWxPNUsxNVd1YXh4ekRTVEkwbUt3SE5kb2RwMVVBOUhKMjRKOU8y?=
 =?utf-8?B?ZnBSTmVWejV4VXlGeUd2UmxOV1VJMmlQcE5pWlRQbzQ3M0RaVE80ZG1nZlJy?=
 =?utf-8?B?ZnA0cUpES1NuR0VvWGE0djJZbE1iTVRiSnlDUmt0VGhLbzFqWlIrQXZnUm16?=
 =?utf-8?B?akxEVmEwWStXL1dZSDlLY0JZbDhtb1F3U090V0JqRjJXSjlqZWpMaHNHSloz?=
 =?utf-8?B?dk4yVDZabmlwenlNTlFnNnI1OC9uTFBkS1pQbHBTek1tY2NuTXZ6SHo1Qzdt?=
 =?utf-8?B?UTlWTTYvZXNKbjhla3JPbUd1YUJJZWhmN1d0YUswYzBhZWZvZlJNQWVVaTNC?=
 =?utf-8?B?YjZOREI0a2dDOHlZQkRrRzg2RjFXZUloT1pwZmhUakVLNlVYeVJJUGxvVFpw?=
 =?utf-8?B?cHRvK3Q4cm13K2N0ZDc0MXVycURac0d3YVdRbHlXMWs1K0xzNzYxVDBMSkZK?=
 =?utf-8?B?bExOdjNQMFZYd3dVcVYwZWhoSVZ1Q1hPci91Y3FTTWxGby9GNXFEWTFyTkt5?=
 =?utf-8?B?K2g2bmUvVkdhQW1MTXJpbEM5MW9yeFBYRVIzQ3dVYXVPSGxKa0IvWjBmWkh6?=
 =?utf-8?B?K1pEeXhNZ2RtekZoRWZFUXhhd01wVjR2TTlYdmprRzNGbHlzcHNWbnhKbXRz?=
 =?utf-8?B?d2Rnbm1DZ1BkVE9NcW4wdWJzaGNkcHpGT0dGME5XejQvQ3E5ejMxQkUvSHVY?=
 =?utf-8?B?Vy8zbCt1SUpZVnRrVnRha3RTVWJhanFWelF1ZCsxV3ZFeXkwa3lEY1prWDlp?=
 =?utf-8?B?MEZYRVNXcjJWS3hBKzBxazdGTUVHRzMyYWNaYmZCZWV0N0lBN1QxSlIzZmx6?=
 =?utf-8?B?S252RnVxKzdYcldlMlVINERXTm5jSkFaaThOSVlVcFRNUzNCNU5tc3dFYWN6?=
 =?utf-8?B?MW54akpKQWN2RmlhYVMxVmNKbEFqYjZnTHF3QVBNRlFxOENPZTM1aDJpZlZJ?=
 =?utf-8?B?UDhTRjVIRzBqVnlVdmFMVFRiRXJIbkJOSEIvbmFUZFlyRXlGWHFtbUVSQStl?=
 =?utf-8?B?WCtSWEM0SDVpYVFHRGR6R0F4QjZKYWNoZllNVE8vZ0hsQzQ3MjlObHRZaFhU?=
 =?utf-8?B?NGdaSGtPRDJYRnVDcmMyMDZGS0JVQ1RycXF0RXVBdTg4cHNud1R4VzlnRXBX?=
 =?utf-8?B?ZU1BZmxVQVFCaGc3ZDBqVHMzblI1MnlUeTMvVEVjOGNVWkZYeVpUQ0VmQVc0?=
 =?utf-8?B?Y2lnL21DcytWbFV5RDdJVDZPYTU5YlY5ZExpa3c4NmNHdE1ac0hsck51N0pK?=
 =?utf-8?Q?BuaFLZ8TADIUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4734334-8b97-438d-b147-08d98e5df070
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:27:16.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8HbrA/i7x11oePs2oZbYkcUgisv23d2CGxt27BxUs6XIQMhFxAC2wLpP+oFawaiYmHrnt3F5L8GTfhvCpQSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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

Hi,

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks a lot, I'm going to apply this patch.

On 2021-10-08 5:21 p.m., Harry Wentland wrote:
> He's been helping maintain it for quite a while now. Make
> it official.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24d520c4b157..b107ddb306de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,6 +876,7 @@ F:	include/uapi/linux/psp-sev.h
>   AMD DISPLAY CORE
>   M:	Harry Wentland <harry.wentland@amd.com>
>   M:	Leo Li <sunpeng.li@amd.com>
> +M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>   L:	amd-gfx@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/agd5f/linux.git
> 

