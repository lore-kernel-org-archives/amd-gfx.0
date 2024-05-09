Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E904BC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2719C10F5A6;
	Thu,  9 May 2024 21:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2q2hiUNo";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD5610F5A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7iEX3ATH+k2CTv4Yzm/bs5s3COSLpuTbLPpWCs42kB3yjwiZphIQTdbiP5/ZbRo9MpsXGgTzEJck3xAAGohxCF6eiOOBLekAKXlRC64a8Zvow25/eNgHjtrFISgnD6Rv+HKh3eyTgbDPdroiC5hk8tLJ6Xkj2GsbuIn5joiDtDD9xc4RVXTqgOOSV1jMjEsRXGV94YAq/b+397p7N7I3m8LX5AVp82koddfHo/Eu6S9fp79nb3rxpwJyX7nVNGKmNnSj1KNU+fjFWETpFEagOaXToVXGBQpqEaiiRhPodjSGJRk5xsl8Ky0J7lL4uRJKFMJlnKTqGVErXlZt9s7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBSHUph4DpY5RU3C7UOg2L0+g/IT0yTjgtqp2/lKfyQ=;
 b=anaxUymN8S8qvTtdMw/h1k5DQbKGFCWytkLbvLNJD86CFNZ6le6VRhKB+1ZL+aDrd4jmgntUNALMAq34G5E0srVk6JLdnWNKhZyIq/s7EQU14+YUYjUHi4DgoBJ03WnTE2c8+1EWsSw2aKYU9TaiOO7VcN/FlxDW0jUBTqngLhhxi5bXkE/t1RYZuzbkCD/senJQcsCvpNgqas/QOJQUyepVzKc9LAaD513lls4cBSXQ3PgoXRN0qNhhX+NMp8lOBk1MBuOEWVlOeezJyhLtjZgnE2FpfDX0cZzPDMLznh7W4aN360f4aWb/HtATNiEUtsnJGNFxOu/CkY+wQFUHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBSHUph4DpY5RU3C7UOg2L0+g/IT0yTjgtqp2/lKfyQ=;
 b=2q2hiUNoX65PRtdsRKo61aWmnit/wMqI/92bqarwZ5g8Y1evSCyr//eUu3cvNcCRKF6Vt3NpZWqgDmJPDg8flsiYFgfuIacoiY5pUIPFxdbACscwcaSVsGgLwgRzqoH/Sbhy3fSybScjLLgJOp6nKmq0486BEhQfcp67upGHSGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 21:31:05 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 21:31:05 +0000
Content-Type: multipart/alternative;
 boundary="------------kW2RbxFsSBbsbljDUjZxBL3N"
Message-ID: <cdd46ba4-4ceb-45d6-a204-4097216df9e2@amd.com>
Date: Thu, 9 May 2024 17:31:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/jpeg: keep drm kernel message consistent
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509204631.1489565-1-David.Wu3@amd.com>
 <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::25) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0c1829-f7f5-4eb6-ff96-08dc706f5533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0RRa2pZeUgwQXFQeWg1Vml6bHpSYVBWeitPZCs2TDBySVFpcTQweGl4b0tz?=
 =?utf-8?B?NVFWeC9VU3RRbUNCZm5qRjlncXZlL21pQnVXbENkVzkzVDg1ZDBiOXNFbFQz?=
 =?utf-8?B?MXd1SGY5dHh6bDRLQUhEYkdUS3V1VU5ta2RtOVBNYkpDR3JpbVpuOHhpRGRD?=
 =?utf-8?B?OWFQUHczWlZmOGtMMTZnQTNFUkM1OGl3WVY0ZC9Pa2xqQ1RFVW5nVmhHMVgz?=
 =?utf-8?B?Mno3bTNwWGhlcG9VOVdFWnUvdFFUWXhlaVVqYWpDYkNKWWZvS0pGbWdKS3M3?=
 =?utf-8?B?SnZlWVBGTW9KdnhYa25MSzVQOVhsMTh1d2k3MW5pTCtsMzJrRDBsbXVRNWNt?=
 =?utf-8?B?dFJGcy8yZE5CdkloVXFwUHlKVE1xUkF1eUtXU28zc1Q1UGFtVmh6dGhhREQz?=
 =?utf-8?B?TmtucHN6S2ErcEVnV3JxK3NaWCs4VGRjM0VLa1NvVUJBYWlpQnFqRGZ2Sm5I?=
 =?utf-8?B?NVdsbjFhVVdkc2ljWkQwcmd2ejF1ckk0RmwzVGZhTzE0SXlkTUJwT3FsdW5S?=
 =?utf-8?B?ci96NUt4SVRDSG40emp0K0RSZDZBSjNDdFNYYzVsMnRockcxY25GUDlDbmxi?=
 =?utf-8?B?MFJoWGF5TVdzZU5vQWlTSzlJNCt4SWN6SFVWQkJHSFdtZnl2bUZFYzI0Y3Z2?=
 =?utf-8?B?dVFuZitPNXAzTDRncDdTakRFeUgySUgwSmtKeUlIQ3l6TUVwUFVnd3k4a0M3?=
 =?utf-8?B?VGVZeFhiaGF0SlFMcmozRGEwbC9ENjJzUWR5eE9raDIvVlRPbFc2UHBaSkVt?=
 =?utf-8?B?QzBoaDhYUHA1bkNuTktodTNYdHpza3lBYXZlSFJWL3FmZktBQW04ekxCOUlU?=
 =?utf-8?B?NEhrcG92MmJTUGRpa2FhNlE2S3I1VHphbTl5d3RubStCRUpld3lmaWJsRy9X?=
 =?utf-8?B?TGNNZXNwTm5FQlRuWkkxYmFOd2FXMFkvckl6SS9YSGZnR1UxVGtqVTI1d3RN?=
 =?utf-8?B?WDJ3Z2kxTllRaVlDZzI5ZTBDZUh2VHZ1MjM5MXZ0dThQMzcxcTR0Qmw2RGgv?=
 =?utf-8?B?VStKQWxPbGJFSEsyMkxLdlhZamc1UG5ETWN5aVB1RS9IMTJsa0haeTNRaDh5?=
 =?utf-8?B?RTkvcnIvekhkbFVHMVJHSm9EMm9CNU9vc0RhQ05TMlQ5TzFVc1BBWFBkY0Ey?=
 =?utf-8?B?MFZhdHBtOXhuQ1FxREVPS1Z1T0lXZUtTZE01WnVocEFWdE9mRjVxT2hkTDBI?=
 =?utf-8?B?NE95SldEZHFST000eUh4VFJDaGxpT2NIZDF0Q1RYTzR0V0ptT2RWVmZ1UEdh?=
 =?utf-8?B?VmRpWGo4aHVyNXNvdWltTVluVkFvQUtPYzJ1V0xUY3BqVnpidkFVTjBQVnB3?=
 =?utf-8?B?KzZwZmhiTmVKczhudE1qRHgyUDBGaGt6MUJXWHNYRXhVSHlLc1F2aVJCSmNt?=
 =?utf-8?B?OUFNZk16cmRPNWJBdVJja2trSmZpMlh4RDY2ZTVuSityYVIrejhhZXR5Rkt6?=
 =?utf-8?B?eG04S1lvTDVCQ2NqZmVJQ0FqY3ZCbTY0TmdXRGRwcXMwd2xGOE1mYk9PUTV0?=
 =?utf-8?B?YVp2cUNuVjNNNWViTTQzZDY5c003djhoaUIwa3hMUndSdDJheTVEWGMxRi96?=
 =?utf-8?B?dU1LWXFwd2NzWU1vOC9xODd6TldOS1o1OUl3REZ5eGNpZW1ramJ0RmlySUo0?=
 =?utf-8?B?eS82ZDNQVkpGRXE1U1ZZTjN2VmhVUWhLcDNXRDd0MHJQcGEyV1pHTUpBcTlq?=
 =?utf-8?B?TlkvcEE0bUdzaTlSczhoYTZ4RlBCN01URkZZSGhLaGNwd0ZpTnNYVzd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlMQ09SYWNOdlFRYnhxSHpXeE5jZmFJdFkxRHFwL1lMZVFhMlQ1cFNiSkNZ?=
 =?utf-8?B?aG1OYzMycW9MeUErYUthdnhiYy9ndHVoN3MrZDBVeUdNdjhBOEV4MDJMZFVz?=
 =?utf-8?B?MW93dzZjUW9hNjhza1FIenYzZUt3RkIyMDVJVFc4NFU5Y1F5bVNSTW9XRkc4?=
 =?utf-8?B?WFJaTmkzVjhQRWR3ajUxcFphT0t0QlZIRjB6S2U2VXRRS0dnRThac0VPcldh?=
 =?utf-8?B?c0VTL3V3L29BYWlpMU5xVjAzZFZzVjgzL3RhNUxRZmNnZEFWL1d3M256WXVp?=
 =?utf-8?B?MlJlRTZzT1pHMVVrV1BkVTFpM0hibTg2ZVEraHUzQ05NTkdhZWg0cG1UaHZU?=
 =?utf-8?B?VmUyZXdTSFhqSnJPa3RxcVV1Q05sa2pLcTk5R3VnRkpUck1lTFZ4aW85bXNI?=
 =?utf-8?B?dHBQbm9HTkwzUU5lOTFUM1hyTy9wTnMwV1N1blRoVzZVZ1pTaXc2YVZQa1dK?=
 =?utf-8?B?L092a2p4WTB5SjFibzlzL01vMk9ocnlUUWEvRWdVRVJjM21vRmNURG1oVStv?=
 =?utf-8?B?cncySWpLRHZvWTl3Q1c4R1JWbjVCaDZibC9DR3VWUnNaRWNjbFBVb2VUa1Zo?=
 =?utf-8?B?a0dyYWswOHJIbk9iUUlQU2ZOTUNRdHBQMzJ5OThuam8rOFpHRjVjUEdnQTJY?=
 =?utf-8?B?UjNCNzhKLzg0QnNySnhJM1puL3VDVWFGYUkzbHB2c1VrODlwV3dpRGdJREpn?=
 =?utf-8?B?WDNXbEFCZ1FuMkFQNXpZbncwU3RYUk4vRWpwMHg0WWxEVnpEa05RUGZZaWpK?=
 =?utf-8?B?QUtGbGNPTFNxaGI2MUlwR3pQSFd2cWw5TVg5dmZiYUZFRDlwaFRtd09SaHFS?=
 =?utf-8?B?UVRCTlBDYlV3YTl0NEF3ZTUyTlBHV2JFdUJVWkNEZG12bE9VNnBMUUZxdGk2?=
 =?utf-8?B?ODFVOW5wd01rM3preGR4SFh0ZXUxa1dSc3A0cWtRcFl6VmI5Ynd3SW1QeGYw?=
 =?utf-8?B?NjlNalJ1WisyQlRBNVh2Si9zdzMyWDNGMG1UN0wrVW52WFdJOUFPMFBMeWp2?=
 =?utf-8?B?QlhQNk5BZ1hzcEROR1c2d2JVNmU5Ymo4bmZ5dm8wRUpCd28velJjSmVMMUd3?=
 =?utf-8?B?Ym5KQVNjdzFqZkNiZU5SaXRWeG80L1phU0szVW5NMTEzbDJTVTVYUWJEQWti?=
 =?utf-8?B?ZjZZZnhZZnBEVDh2ZEFKbDJaWHBObGNSMGRsbEJiUE9FU1hKbVFLRWRoNS9S?=
 =?utf-8?B?YzF5Sm5obG9EUXNtaHcxKy81WjVnTk1RYXYrMHY2ekF3VUFaWGFoc1V6b3o2?=
 =?utf-8?B?YWpVdG93eG1NbFFwOHZrOWNBbzZyWHZXaVNIY3BvWSs2NjU3ajNZWkxmNDFi?=
 =?utf-8?B?Q1hNbkl4amt3dzN1NG10SFBza3BnaC9IWGZsN2tqOU5UT1ZiNWhYRGxRd0Vw?=
 =?utf-8?B?dGJtNHNmeWo1WkFvMHdFUS90bWYxOU9KVC9zcmliNFNoL3lxRE1xUmMvSVU5?=
 =?utf-8?B?UHFaSjRmNy9UNEtsVkVua3c4K1dTcTlHSHgwN28rN012a2d2RWtCTU5seEo4?=
 =?utf-8?B?RlhhOHFza2lQT3VFNFV2eXF1UXZXTlJDK1Nzc2RScGEwTXdmaEZZYXg0bEt4?=
 =?utf-8?B?Q0xRUGxzRjZlWU5uay9Fb2kzU2RVMzh0L0drNG9rOFJNektVMXVWOHJXSXFq?=
 =?utf-8?B?TS9mYnVvb2ZLZnkxRkJlRWRmeEVFcWdRRzlJcVd2KzBCRC9nemo0SFpSaTQ2?=
 =?utf-8?B?NnRTT25iWkNQUzU1RGJNWCtnZEJxTTA5c21CVjlUUkVwbXZyS0VSL0l5UVIz?=
 =?utf-8?B?WVZSWW1ZNVRaOFE0aDZmc05vZ3N5NVlTVjl5RXNOVG9xZDNtTDA0Ylkwa2Vw?=
 =?utf-8?B?ak9td08rVmo1djVKR1hzdlB2RTJUTDdFUFpFTFUrNkpXd09hRUNkenY4Rk1z?=
 =?utf-8?B?ekQ4Q0Zybi9oY0RpK3JGb3dTbEMzZDM4c01ZUjFsOGVKUkZLWHBQRTJSenI2?=
 =?utf-8?B?R2d6ckJ4Y1Zhd1Jub1dEU1R5a25LeVgyQ0l2UCtNRk9EQlhYSE01S0U2MHdk?=
 =?utf-8?B?WThNWGxVcXVrRGRWdGJhVTkxS1FxVkNCUlJoVURaU0JSeTVESFI2bFkwYUY4?=
 =?utf-8?B?SzNJK1FZMDkrU1Mzb3h2SE5EOGF1QmRKWXBBU09mV0hSaFlkb3JVTEwvb1U3?=
 =?utf-8?Q?gSipatxaYu+gSg3W8XhIF66fW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0c1829-f7f5-4eb6-ff96-08dc706f5533
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:31:05.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1cNrFsCDzycgUJc2O1uxuriNCdgMVsEGGtl162wsred5/dk9um6N6GqPJa0UJ2/Ob/wPKTIRTNRjYRtEELaoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

--------------kW2RbxFsSBbsbljDUjZxBL3N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

Thanks for the suggestion!
What I am thinking is "DRM_DEV_INFO" should not be the one we want - as 
it is more like a debug message.

    [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.

instead I prefer to use this format:
"amdgpu 0000:43:00.0: amdgpu: JPEG decode initialized successfully."

but again I dislike it as well as there are 2 "amdgpu"s in the same message.

To make it consistent the "DRM_INFO" is used everywhere in the amdgpu code.
only the following jpeg code uses DRM_DEV_INFO and one file for vcn. All 
other jpeg versions have already changed to DRM_INFO.

    grep -r DRM_DEV_INFO *
    amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode
    initialized successfully.\n");
    amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode is
    enabled in VM mode\n");
    amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode initialized
    successfully(under %s).\n",
    amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode is enabled
    in VM mode\n");
    amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG decode
    initialized successfully under DPG Mode");
    amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is
    enabled in VM mode\n", i);
    amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode
    initialized successfully under DPG Mode");
    amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is
    enabled in VM mode\n", i);
    amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized
    successfully.\n");
    amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode is enabled
    in VM mode\n");

If the rest of code in amdgpu uses DRM_INFO why should we make VCN and 
JPEG special?
To address the identification of which GPUs - we need to check the 
kernel message after each IP DISCOVERY.
I do not see a reason to mess them up.
Regards,
David
On 2024-05-09 16:59, Alex Deucher wrote:
> On Thu, May 9, 2024 at 4:57 PM David (Ming Qiang) Wu<David.Wu3@amd.com>  wrote:
>> amdgpu jpeg kernel message is different than others such as vcn:
>>    [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.
>>
>> This patch is to make them consistent.
>>
>> The message after the change is:
>>    [drm] JPEG decode initialized successfully.
> Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
> tell which GPUs these messages refer to on multi-GPU systems.
>
> Alex
>
>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index 64c856bfe0cb..4be0668ab97d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>>          if (r)
>>                  return r;
>>
>> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
>> +       DRM_INFO("JPEG decode initialized successfully.\n");
>>
>>          return 0;
>>   }
>> @@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
>>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>>   {
>>          adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
>> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>> +       DRM_INFO("JPEG decode is enabled in VM mode\n");
>>   }
>>
>>   static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
>> --
>> 2.34.1
>>
--------------kW2RbxFsSBbsbljDUjZxBL3N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Alex,</p>
    Thanks for the suggestion!<br>
    What I am thinking is &quot;<span style="white-space: pre-wrap">DRM_DEV_INFO&quot; should not be the one we want - as it is more like a debug message.</span><br>
    <blockquote> [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode
      initialized successfully.<br>
    </blockquote>
    <span style="white-space: pre-wrap">instead I prefer to use this format:</span><br>
    <span style="white-space: pre-wrap">	&quot;amdgpu 0000:43:00.0: amdgpu: </span><span style="white-space: pre-wrap">JPEG decode initialized successfully.&quot;</span><br>
    <p><span style="white-space: pre-wrap"></span><span style="white-space: pre-wrap">but again I dislike it as well as there are 2 </span><span style="white-space: pre-wrap">&quot;amdgpu&quot;</span><span style="white-space: pre-wrap">s in the same message.</span></p>
    <span style="white-space: pre-wrap">To make it consistent the &quot;</span><span style="white-space: pre-wrap">DRM_INFO&quot; is used everywhere in the amdgpu code.</span><br>
    <span style="white-space: pre-wrap">only the following jpeg code uses DRM_DEV_INFO and one file for vcn. All other jpeg versions have already changed to </span><span style="white-space: pre-wrap">DRM_INFO.</span><br>
    <blockquote><span style="white-space: pre-wrap">    grep -r DRM_DEV_INFO *</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0_3.c:	DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0_3.c:	DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/vcn_v4_0_3.c:		DRM_DEV_INFO(adev-&gt;dev, &quot;VCN decode initialized successfully(under %s).\n&quot;,</span><br>
      <span style="white-space: pre-wrap">    amdgpu/vcn_v4_0_3.c:	DRM_DEV_INFO(adev-&gt;dev, &quot;VCN decode is enabled in VM mode\n&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0_5.c:		DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully under DPG Mode&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0_5.c:		DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG%d decode is enabled in VM mode\n&quot;, i);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v5_0_0.c:		DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully under DPG Mode&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v5_0_0.c:		DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG%d decode is enabled in VM mode\n&quot;, i);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0.c:	DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);</span><br>
      <span style="white-space: pre-wrap">    amdgpu/jpeg_v4_0.c:	DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);</span><span style="white-space: pre-wrap"></span><br>
      <span style="white-space: pre-wrap"></span><br>
    </blockquote>
    <div class="moz-cite-prefix">If the rest of code in amdgpu uses <span style="white-space: pre-wrap">DRM_INFO why should we make VCN and JPEG special?</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">To address the identification of which GPUs - we need to check the kernel message after each IP DISCOVERY.</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">I do not see a reason to mess them up.</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">Regards,</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">David
</span></div>
    <div class="moz-cite-prefix">On 2024-05-09 16:59, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, May 9, 2024 at 4:57 PM David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
amdgpu jpeg kernel message is different than others such as vcn:
  [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.

This patch is to make them consistent.

The message after the change is:
  [drm] JPEG decode initialized successfully.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
tell which GPUs these messages refer to on multi-GPU systems.

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 64c856bfe0cb..4be0668ab97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
        if (r)
                return r;

-       DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);
+       DRM_INFO(&quot;JPEG decode initialized successfully.\n&quot;);

        return 0;
 }
@@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
        adev-&gt;jpeg.inst-&gt;ring_dec-&gt;funcs = &amp;jpeg_v5_0_0_dec_ring_vm_funcs;
-       DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);
+       DRM_INFO(&quot;JPEG decode is enabled in VM mode\n&quot;);
 }

 static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------kW2RbxFsSBbsbljDUjZxBL3N--
