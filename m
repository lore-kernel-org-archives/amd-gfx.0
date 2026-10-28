Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BB606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ivMpV3vK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F3510E12B;
	Wed, 28 Oct 2026 17:50:34 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9158310E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu2Eo7XFboytR0wL/JvqCA41p8YBjwLaupqQ5vOgJMEeiiI3IPyQ+3iC4SfMiPYGDFH+jhrcREFzd6tp7/Bm4l33s6/wOJGWlH0eCBHU1/a16NffasjHT0AaCOhiMsGihbypVacnD9zYa6Yu0qBMcti3J0D7VEyz5PrcNQ1zQbOjEF0zxbH5Q/7pAUpDKlRCBandj7TtZUqpjyDKYFRJ2cbIhlg74w9qFmVlbk3Kdr6qrUpg50HCFxpGzt1umXvIHBnnjZUazDtFLIFLbJSfXDaiRwymyxkeEhqYtUKxICcb7gfrra5t5cK0PtZ+Bu9cWxy0PeYlZKNKMkB+fxw/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFy+x2W9qTUap3/42vy1WeIzr6J5ZczKr5YspPvSOHs=;
 b=MZ1DEHJsbpkHHVN19LDIsG6fxMYweTnraAgFAnZHqNCU6wHQgSkxkxTjZOHY9tqqRJ34kSO6yQVm5EnyRm+lSl84jiCxj0U0cDqrqWAZUrYKUVbGd/3SUpKB5nUUMsIgvqJPpgMMDw9QnmgPVfVSCfsW/GXRjmhMaqU+E88SsNGznQzDmG0kFqadLPVD5a12idn4YpVJ2Jd9FK5pR3Iet4eIXxoZRqU+TM9FYxoRXwB429lro5qS0WBXPGvpGlVCcUjsZFxj3UUu4vcPcGmBrQD1J1INxK9nwRsKlhoXocRe1xUiTYeMTlaMRXVM6sBpxSPuTaR+O9v6aqGBwqcW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFy+x2W9qTUap3/42vy1WeIzr6J5ZczKr5YspPvSOHs=;
 b=ivMpV3vKHKLQ/67JnV1VMQNRTdVyrIAy0yUWyclwFSacWRtlawS5IQO5eAo8J0IY1MYYm8MD9LWBOIjNerODhJEGqCYpxejR7Ll37+eR3dJ2ffI3NbslzDM2eMCH2E3B8e1jZ0Jobxi8en7+C82i4ou/1X8he+a973mP8Y4nb3k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:50:24 +0000
Received: from MW4PR12MB5604.namprd12.prod.outlook.com
 ([fe80::c09b:b4f7:d646:efe1]) by MW4PR12MB5604.namprd12.prod.outlook.com
 ([fe80::c09b:b4f7:d646:efe1%2]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 17:50:23 +0000
Message-ID: <68d321fc-1a2e-4de4-8dd5-b7171a319a5f@amd.com>
Date: Wed, 28 Oct 2026 17:50:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vladimir Indic <vladimir.indic@amd.com>
References: <20261022204858.4143484-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20261022204858.4143484-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To MW4PR12MB5604.namprd12.prod.outlook.com
 (2603:10b6:303:18d::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5604:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fff9494-06cd-4be8-ee3e-08df351bf0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|261026121527099003|3023799007|56012099006|261021121427099003|11063799006|261022075727099003|261009223027099003|261022105027099003|261021123027099003|261026140227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: NgIuFdkBjIL+Bnr3eQ4GeLdKt0fEhBnN1aEK2zuj67CRelkNIjQtU+dNJRt0he87yj/FoGR6xDjKRWiysYKPmVi1a3hZT+nImWxoTPnifqmZCXuZQ4/HkGytl7KPWYFgPomLFdqEr3vIry1QWNDTXhkk1drLU6Il6Kjvj4dGAd1sm2ytvwCpy43vD6auhc5x4GpqcBzc7jH+OUUcLry2l1MaxnkcGx9nHEeM4szec3UvrKLf7Id/+DGRaO6GPxQ4M/6XdfQUrsRMmuFMgNtM/YIX71/UOaJ0qO86iFXDV7aMsAsrVpI2i5S3It3XmScg65Tq1fYx1qndOpBarY4gCZmjtrPYYrg7NLbT0xNn1JH0BPrhuO+laR1EOFF9Dk++M/n4IykokqlfXew4/Fq+iWbXDgmn01Af3MqGzwlHyqTKuXf61tX1ZVUCTusuibNb2CATryLaPXF+CeLC3dMelFYXpdpsSQb9tLx+2Ygl/lxkTiw0jDbNfoJeEvmJwO2Ynx2ahYvpcD5q9EcgzykbDe8tbOQ819ujTskIIz72wmkLNy6pSaaJ4V8l30lJWOkCvA6UqB0tPPE+RqoWKaZt1cvzdqa+OPday3GgeDIqEMyZVDYykub0973Bdq2m4oHr0fkVk6wubN0/fmAr4Ow8gtfnYuxqEff4LKBXx8B0e18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(261026121527099003)(3023799007)(56012099006)(261021121427099003)(11063799006)(261022075727099003)(261009223027099003)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERiWGpCd1p3SmJhQStMc3ovTGF5WmloTmE1c2dJRW8xRCtEcWlEK0tHNTJN?=
 =?utf-8?B?Y0tOLzJaRWRINTFad0FTUFMrSWxYRHY2MTVCNEhneEpsalJqN3dUTC9VVlNH?=
 =?utf-8?B?Q0hUa1IzREU2ZW9ONFNnRHdZWHh1eitLRW12amJDcE5PYWZIbjRrRkYwZUJi?=
 =?utf-8?B?NC9uZkNuemUwbTFOYy94UUdUMTlHNitISmUrMS9uUGRqTnBFbjRsYkMzdFVY?=
 =?utf-8?B?Ni9UYmNYT2wzekJ4ZmxrNEVDcmlVLzlwZXRkMm1HQXBVYjRCcE9SZTVzenpS?=
 =?utf-8?B?Nlp4NVhuNlVUZkhJRFJUeFNObmEyNWVjT3VoMWk3UFhZZXNQemZVUldHN3Jw?=
 =?utf-8?B?NU9XZnVUbkh5alRtY05WUDIySkdScXBlS2RLTFkwRUFSNlZadEUxN2NMSEdo?=
 =?utf-8?B?OFc5VlhLeGU3cFVpd2J6RHhlSE5MM0FrbWFDOENBdGpwVGRsYWlWYVN4U1Bj?=
 =?utf-8?B?Y2ovYUw4NnA2bUVmc0gyL21sOFFkWHcyQ0JDOGFxYmZNbHlha2M5V0dVZ1dv?=
 =?utf-8?B?TzZoaGZQZllXMHBBRjErZHpVcjBnTXMvSFJTc291UDdUb1M4QzZvd3dCOUZ5?=
 =?utf-8?B?N04ycGlWaHRnVEtIVEJ5aHlrNE40QlhiTUtCZTgwYjVLVUxZblhQY3c5UXg4?=
 =?utf-8?B?OVN3QUhLQU1wVlVRN3h3RG1ua0JnZFMvM21jYjBXTXlRbjZGaWdaT1lNVStt?=
 =?utf-8?B?TE96OSs3TXQrUWFEaVhRZnRienJkOG9OR0FDS2QyRkl6ZjhhVCszSU9kWVlC?=
 =?utf-8?B?QlBTWjRyNkpacmZrSVBkdFVHa1drS2FJbXppMEhDNVVUcjMweGpONWMzVHBo?=
 =?utf-8?B?OTFVekkxZkNLaXJPYXhkWWZxTXFVdDhXc2xNOVFoL20wcndKNG1aOW4xQmE3?=
 =?utf-8?B?djRSUXB5UDRBS0QwSkVYN0lzMTh5VUpiR0hJWE1pZk1PNGNFV21lYjlDMTE3?=
 =?utf-8?B?TEY2aDAwdFBlOUd4aXIxVmdSd1p0bkI3SXEvZ3NYdUc1MUtlVC9JTVlTZmo1?=
 =?utf-8?B?MEc0Nmc0R01IVjJQejRwcWxuU2FZTElkd3krZktjL1hGN3hHUzBaSG1GVDgw?=
 =?utf-8?B?YXo5MC91Y2g2NWhsb1JNYnVuVVgxbkJHM3dIVjJqWENPdUR5TU9kcXRxR2ds?=
 =?utf-8?B?dUtHTG9qMzRCVkNndXJ5cHUwdGorOVNjZitEOTlIc1h0ekp1UmhMZlZKWHh6?=
 =?utf-8?B?eFRsdVpvUlJPdTR1c2lUZE91dE5SYzF6aURvcDdoblJ5OXFldWR0MjhRdGE3?=
 =?utf-8?B?dkdyRUdKYUZXM0RqdHNTWEQ1dEo1UVY2aEVrVmk1emQ0eEN2TVg4SEVzaEpa?=
 =?utf-8?B?V2xGY3pZQ0lxc1VUMnh2TkFBeUJSSWZyaDZqQUVzSVRrNWFTa2pzZHl0ZjRJ?=
 =?utf-8?B?U2gvbWpZc2dRSXozZDVrVkIxS3RDNTc3UjV3MkVhd3hzam9BRVdId2VIR1hR?=
 =?utf-8?B?T3JEc2RIQzFQT2VhVEVZREhmWDcyTXlCKzJ2dFBZZklHV1p0ckRyUG9tcHIr?=
 =?utf-8?B?USt2YXo5UXlWVzdIbW5sSGxYZmIxcWtWeGlZMHowUHlJZVBUQWQxeUdwcXBK?=
 =?utf-8?B?cmRZSm85d3N2R0ZvTDVFTE82QWp6NEM4UXZNZkduRmlscHlrM2wvUmpuRVl2?=
 =?utf-8?B?RHhyeXFvSnZWUzVic0xLYlJvL3krRk91ZG1telp6am5ZUFhnb3ZjdUprVXd5?=
 =?utf-8?B?RC9teVp3RGR1US9IY0p4RGJ3aWpjVVNFL2xOLytWTXRUSmlQczErK2w1V3lo?=
 =?utf-8?B?NU10SHJLcFRZSGJIVXVOUU41MThLZzVCRXcvNW9ndzdnNmtFb2I3SGtrSktD?=
 =?utf-8?B?Mzg3L0tkYW5lcjh0eWVOQXNtTVVZQ2FzSG9veDU2YUdVZm5ZeXhzbEx1SkdB?=
 =?utf-8?B?STdHV2FVTFVuaUMyaE9CU2FJV0x3N01IamMvSmM4R2dvOTBmVzgwT1FGZVNt?=
 =?utf-8?B?MFovN1hWS3A3dVJqRzEwM2VJM3orZ21OWmE1MElhc09QRk9MaWw1cFNqVnVH?=
 =?utf-8?B?ay9VQzRld0t3L1l6R1BuQXp1bnZ4WmtPem5mcjFROElVMTQzeGh3WUgwQ3d1?=
 =?utf-8?B?VlVNTDNFME80UXQxbm9kU0owM2RFV3Q3YTdMWDRTaTRUZGpjcHpBYUFXclFn?=
 =?utf-8?B?dXJhMVVvdG84Qm56MjR3QjQzTXRmeHFURTFjaUp3NTZOb3orT3VNelBxZWtF?=
 =?utf-8?B?VUJKNk1hejB2RFhvRlY4MlR6WmQ1aHNYazVnODRoZzVJU3pMTWQ0NzdNRlZp?=
 =?utf-8?B?Rll4d2FtU1hVWkVXWGRkNlcrYmFXYTlUbXpqQ0xBUk91aFliYmhaMjFzaGNH?=
 =?utf-8?Q?qumAiP/JxMeKZkullA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fff9494-06cd-4be8-ee3e-08df351bf0f5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:50:23.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeBToEZw9uXn6EJ2hcKJODNpd/ZWMaEoaul+5+F+N75sDMP2F8ol5+Jp6Lfb98vGS8O0FpZRs9J7PK/FH18Uqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Sorry for the delay.

A couple of (minor) remarks below.

On 22/10/2026 21:48, Jay Cornwall wrote:
> Split instruction fixup into two separate workarounds:
> - Trap during VOP3PX: revision 0 only
> - Trap during VALU/SET_VGPR_MSB: revision 0 and 1
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 695 +++++++++++++++++-
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  43 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  12 +-
>   3 files changed, 729 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 5cf306de0d96..5d468460f532 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -4600,7 +4600,7 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
>   	0xbf9b0000, 0x00000000,
>   };
>   
> -static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
> +static const uint32_t cwsr_trap_gfx12_1_0_rev_0_hex[] = {
>   	0xbfa00001, 0xbfa003e2,
>   	0xb0804009, 0xb8f8f804,
>   	0xbefa007e, 0xbefe0081,
> @@ -5301,3 +5301,696 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
>   	0xbf9f0000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
>   };
> +
> +static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] = {
> +	0xbfa00001, 0xbfa003d0,
> +	0xb0804009, 0xb8f8f804,
> +	0xbefa007e, 0xbefe0081,
> +	0xbeee0080, 0xbeef00c1,
> +	0xee17406e, 0x00040000,
> +	0x00000000, 0xbefe007a,
> +	0x9178ff78, 0x00008c00,
> +	0xb8fbf811, 0xbf0c877b,
> +	0xbfa20002, 0x916dff6d,
> +	0xf0000000, 0xbf0d857b,
> +	0xbfa10006, 0x917bff7b,
> +	0x00000480, 0xb98001d1,
> +	0x00000000, 0xb9800291,
> +	0x00000000, 0x8b6eff78,
> +	0x00004000, 0xbfa10008,
> +	0x8b6eff7b, 0x00000480,
> +	0xbfa20018, 0x8b6ea07b,
> +	0xbfa200e1, 0xbf830010,
> +	0xb8fbf811, 0xbfa0fffb,
> +	0x8b6eff7b, 0x00000bd0,
> +	0xbfa20010, 0xb8eef812,
> +	0x8b6f8f7b, 0xbfa10002,
> +	0x8c6eff6e, 0x00000080,
> +	0xb8eff813, 0x8b6e6e6f,
> +	0xbfa20008, 0x8b6eff6d,
> +	0xf0000000, 0xbfa20005,
> +	0x8b6fff6f, 0x00000200,
> +	0xbfa20002, 0x8b6ea07b,
> +	0xbfa200cb, 0x9177ff77,
> +	0x007fc000, 0xb8fa04a1,
> +	0x847a967a, 0x8c777a77,
> +	0xb8fa0421, 0x847a957a,
> +	0x8c777a77, 0xb8fa3021,
> +	0x847a8e7a, 0x8c777a77,
> +	0xb980f821, 0x00000000,
> +	0xbeef007b, 0xbefa4d82,
> +	0xbf8a0000, 0x84fa887a,
> +	0xbf0d987b, 0xbfa10002,
> +	0x8c7bff7b, 0xfe000000,
> +	0xf4601bbd, 0xf8000010,
> +	0xbf8a0000, 0x846e976e,
> +	0x9177ff77, 0x03800000,
> +	0x8c776e77, 0x8b6eff6f,
> +	0x00000480, 0xbfa1000c,
> +	0xbf0d8e78, 0xbfa20002,
> +	0xbf0d9877, 0xbfa20002,
> +	0xb98001d1, 0x00000000,
> +	0xbf0d8e78, 0xbfa20002,
> +	0xbf0d9977, 0xbfa20002,
> +	0xb9800291, 0x00000000,
> +	0xf4603bbd, 0xf8000000,
> +	0xbf8a0000, 0xf4603ebd,
> +	0xf8000008, 0xbf8a0000,
> +	0x8bee6e6e, 0xbfa10001,
> +	0xbe80486e, 0x8b6eff6d,
> +	0xf0000000, 0xbfa20009,
> +	0xb8eef811, 0x8b6eff6e,
> +	0x00000080, 0xbfa20007,
> +	0x8c78ff78, 0x00004000,
> +	0x80ec886c, 0x82ed806d,
> +	0xbfa00002, 0x806c846c,
> +	0x826d806d, 0x8b6dff6d,
> +	0x01ffffff, 0xb8fbf811,
> +	0xbf0d847b, 0xbfa20078,
> +	0xf4003eb6, 0xf8000000,
> +	0xbfc70000, 0xf4003bb6,
> +	0xf8000008, 0x8b76ff7a,
> +	0x80000000, 0xbfa20027,
> +	0x9376ff7a, 0x00060019,
> +	0x81f9a376, 0xbf0b8179,
> +	0xbfa20068, 0x81f9ac76,
> +	0xbf0b8179, 0xbfa20062,
> +	0x81f9b776, 0xbf0b8179,
> +	0xbfa2005f, 0x8b76ff7a,
> +	0x000001ff, 0xbf06ff76,
> +	0x000000fe, 0xbfa2005d,
> +	0xbf06ff76, 0x000000ff,
> +	0xbfa20057, 0xbf06ff76,
> +	0x000000fa, 0xbfa20054,
> +	0x81f9ff76, 0x000000e9,
> +	0xbf0b8179, 0xbfa20050,
> +	0x8b76ff7b, 0xffff0000,
> +	0xbf06ff76, 0xbf860000,
> +	0xbfa10051, 0x9376ff7b,
> +	0x0002000e, 0x8b79ff7b,
> +	0x00003f00, 0x85798679,
> +	0x8c767976, 0xb9763b01,
> +	0xbfa00049, 0x8b76ff7a,
> +	0xfc000000, 0xbf06ff76,
> +	0xd4000000, 0xbfa20013,
> +	0xbf06ff76, 0xc8000000,
> +	0xbfa20027, 0x8b76ff7a,
> +	0xff000000, 0xbf06ff76,
> +	0xcf000000, 0xbfa20039,
> +	0x8b79ff7a, 0xffff0000,
> +	0xbf06ff79, 0xcc350000,
> +	0xbfa20037, 0xbf06ff79,
> +	0xcc3a0000, 0xbfa20034,
> +	0xbf06ff76, 0xcc000000,
> +	0xbfa10031, 0x8b76ff7b,
> +	0x000001ff, 0xbf06ff76,
> +	0x000000ff, 0xbfa20029,
> +	0xbf06ff76, 0x000000fa,
> +	0xbfa20026, 0x81f6ff76,
> +	0x000000e9, 0xbf0b8176,
> +	0xbfa20022, 0x8b76ff7b,
> +	0x0003fe00, 0xbf06ff76,
> +	0x0001fe00, 0xbfa2001d,
> +	0x8b76ff7b, 0x07fc0000,
> +	0xbf06ff76, 0x03fc0000,
> +	0xbfa20018, 0xbfa00014,
> +	0x9376ff7a, 0x00040016,
> +	0x81f68176, 0xbf0b8176,
> +	0xbfa20012, 0x9376ff7a,
> +	0x00050011, 0x81f68176,
> +	0xbf0b8176, 0xbfa2000d,
> +	0x8b76ff7a, 0x000001ff,
> +	0xbf06ff76, 0x000000ff,
> +	0xbfa20008, 0x8b76ff7b,
> +	0x000001ff, 0xbf06ff76,
> +	0x000000ff, 0xbfa20003,
> +	0xbfc70000, 0xbefb006e,
> +	0xbfa0ffad, 0xbfc70000,
> +	0xbefb006f, 0xbfa0ffaa,
> +	0xbfc70000, 0x857a9677,
> +	0xb97a04a1, 0x857a9577,
> +	0xb97a0421, 0x857a8e77,
> +	0xb97a3021, 0x8bfe7e7e,
> +	0x8bea6a6a, 0x85788978,
> +	0xb9783244, 0xbe804a6c,
> +	0xb8faf802, 0xbf0d987a,
> +	0xbfa10001, 0xbfb00000,
> +	0x8b6dff6d, 0x01ffffff,
> +	0xbefa0080, 0xb97a0151,
> +	0x9177ff77, 0x007fc000,
> +	0xb8fa04a1, 0x847a967a,
> +	0x8c777a77, 0xb8fa0421,
> +	0x847a957a, 0x8c777a77,
> +	0xb8fa3021, 0x847a8e7a,
> +	0x8c777a77, 0xb980f821,
> +	0x00000000, 0xbf0d847b,
> +	0xbfa20078, 0xf4003eb6,
> +	0xf8000000, 0xbfc70000,
> +	0xf4003bb6, 0xf8000008,
> +	0x8b76ff7a, 0x80000000,
> +	0xbfa20027, 0x9376ff7a,
> +	0x00060019, 0x81f9a376,
> +	0xbf0b8179, 0xbfa20068,
> +	0x81f9ac76, 0xbf0b8179,
> +	0xbfa20062, 0x81f9b776,
> +	0xbf0b8179, 0xbfa2005f,
> +	0x8b76ff7a, 0x000001ff,
> +	0xbf06ff76, 0x000000fe,
> +	0xbfa2005d, 0xbf06ff76,
> +	0x000000ff, 0xbfa20057,
> +	0xbf06ff76, 0x000000fa,
> +	0xbfa20054, 0x81f9ff76,
> +	0x000000e9, 0xbf0b8179,
> +	0xbfa20050, 0x8b76ff7b,
> +	0xffff0000, 0xbf06ff76,
> +	0xbf860000, 0xbfa10051,
> +	0x9376ff7b, 0x0002000e,
> +	0x8b79ff7b, 0x00003f00,
> +	0x85798679, 0x8c767976,
> +	0xb9763b01, 0xbfa00049,
> +	0x8b76ff7a, 0xfc000000,
> +	0xbf06ff76, 0xd4000000,
> +	0xbfa20013, 0xbf06ff76,
> +	0xc8000000, 0xbfa20027,
> +	0x8b76ff7a, 0xff000000,
> +	0xbf06ff76, 0xcf000000,
> +	0xbfa20039, 0x8b79ff7a,
> +	0xffff0000, 0xbf06ff79,
> +	0xcc350000, 0xbfa20037,
> +	0xbf06ff79, 0xcc3a0000,
> +	0xbfa20034, 0xbf06ff76,
> +	0xcc000000, 0xbfa10031,
> +	0x8b76ff7b, 0x000001ff,
> +	0xbf06ff76, 0x000000ff,
> +	0xbfa20029, 0xbf06ff76,
> +	0x000000fa, 0xbfa20026,
> +	0x81f6ff76, 0x000000e9,
> +	0xbf0b8176, 0xbfa20022,
> +	0x8b76ff7b, 0x0003fe00,
> +	0xbf06ff76, 0x0001fe00,
> +	0xbfa2001d, 0x8b76ff7b,
> +	0x07fc0000, 0xbf06ff76,
> +	0x03fc0000, 0xbfa20018,
> +	0xbfa00014, 0x9376ff7a,
> +	0x00040016, 0x81f68176,
> +	0xbf0b8176, 0xbfa20012,
> +	0x9376ff7a, 0x00050011,
> +	0x81f68176, 0xbf0b8176,
> +	0xbfa2000d, 0x8b76ff7a,
> +	0x000001ff, 0xbf06ff76,
> +	0x000000ff, 0xbfa20008,
> +	0x8b76ff7b, 0x000001ff,
> +	0xbf06ff76, 0x000000ff,
> +	0xbfa20003, 0xbfc70000,
> +	0xbefb006e, 0xbfa0ffad,
> +	0xbfc70000, 0xbefb006f,
> +	0xbfa0ffaa, 0xbfc70000,
> +	0xbeee007e, 0xbeef007f,
> +	0xbefe0180, 0xbefe4d84,
> +	0xbf8a0000, 0x8b7aff7f,
> +	0x04000000, 0x847a857a,
> +	0x8c6d7a6d, 0xb8eff822,
> +	0xb980f822, 0x00000000,
> +	0xb8fa2b01, 0x847a997a,
> +	0x8c6d7a6d, 0xbefa0080,
> +	0xb97a2b01, 0xbefa007e,
> +	0x8b7bff7f, 0x01ffffff,
> +	0xbefe00c1, 0xbeff00c1,
> +	0xee0a407a, 0x000c0000,
> +	0x00000000, 0x7e000280,
> +	0xbefe007a, 0xbeff007b,
> +	0xb8fb0742, 0x847b997b,
> +	0xb8fa3b05, 0x807a817a,
> +	0xbf0d997b, 0xbfa20002,
> +	0x847a897a, 0xbfa00001,
> +	0x847a8a7a, 0x8b7bff7f,
> +	0x01ffffff, 0x807aff7a,
> +	0x000001c0, 0x807a7e7a,
> +	0x827b807b, 0xd7610000,
> +	0x00010870, 0xd7610000,
> +	0x00010a71, 0xd7610000,
> +	0x00010c72, 0xd7610000,
> +	0x00010e73, 0xd7610000,
> +	0x00011074, 0xd7610000,
> +	0x00011275, 0xd7610000,
> +	0x00011476, 0xd7610000,
> +	0x00011677, 0xd7610000,
> +	0x00011a79, 0xd7610000,
> +	0x00011c7e, 0xd7610000,
> +	0x00011e7f, 0xbefe00ff,
> +	0x00003fff, 0xbeff0080,
> +	0xee0a407a, 0x000c0000,
> +	0x00000000, 0xd760007a,
> +	0x00011d00, 0xd760007b,
> +	0x00011f00, 0xbefe007a,
> +	0xbeff007b, 0xbef4007e,
> +	0x8b75ff7f, 0x01ffffff,
> +	0xbef1007d, 0xb8f30742,
> +	0x84739973, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00002,
> +	0xbeff00c1, 0xbfa0000a,
> +	0xee0a4074, 0x008c0000,
> +	0x00008000, 0xee0a4074,
> +	0x010c0000, 0x00010000,
> +	0xee0a4074, 0x018c0000,
> +	0x00018000, 0xbfa00009,
> +	0xee0a4074, 0x008c0000,
> +	0x00010000, 0xee0a4074,
> +	0x010c0000, 0x00020000,
> +	0xee0a4074, 0x018c0000,
> +	0x00030000, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0x8070ff70, 0x00000200,
> +	0x7e000280, 0x7e020280,
> +	0x7e040280, 0xbefd0080,
> +	0xd7610002, 0x0000fa71,
> +	0x807d817d, 0xb8faf802,
> +	0xbf0c8b7a, 0xbfa20003,
> +	0xbe804fc2, 0xbf94fffe,
> +	0xbfa10001, 0xbe804ec4,
> +	0xbf94fffc, 0xbefa4c88,
> +	0xbfc70000, 0xbf0c807a,
> +	0xbfa20006, 0x9371ff7a,
> +	0x00070004, 0x937aff7a,
> +	0x00070010, 0xbf06717a,
> +	0xbfa2fff6, 0xb8faf804,
> +	0x8b7aff7a, 0x0001000c,
> +	0x9178ff78, 0x0001000c,
> +	0x8c787a78, 0xd7610002,
> +	0x0000fa6c, 0x807d817d,
> +	0x8b7aff6d, 0x01ffffff,
> +	0xd7610002, 0x0000fa7a,
> +	0x807d817d, 0xd7610002,
> +	0x0000fa6e, 0x807d817d,
> +	0xbefa0080, 0xd7610002,
> +	0x0000fa7a, 0x807d817d,
> +	0xd7610002, 0x0000fa78,
> +	0x807d817d, 0xb8faf811,
> +	0xd7610002, 0x0000fa7a,
> +	0x807d817d, 0xd7610002,
> +	0x0000fa6f, 0x807d817d,
> +	0xb8f1f801, 0x937aff6d,
> +	0x00060019, 0x847a8c7a,
> +	0x8c717a71, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f814, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f815, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f812, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f813, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8faf802, 0xd7610002,
> +	0x0000fa7a, 0x807d817d,
> +	0xbefa50c1, 0xbfc70000,
> +	0xd7610002, 0x0000fa7a,
> +	0x807d817d, 0xbefa4c88,
> +	0xbfc70000, 0xd7610002,
> +	0x0000fa7a, 0x807d817d,
> +	0xb8faf81a, 0xd7610002,
> +	0x0000fa7a, 0x807d817d,
> +	0xbefe00c1, 0xbeff0080,
> +	0x80767074, 0x82778075,
> +	0xee0a4076, 0x010c0000,
> +	0x00000000, 0xbefe00c1,
> +	0x7e040280, 0xbefa5081,
> +	0xbfc70000, 0xd7610002,
> +	0x0001007a, 0xbefa5082,
> +	0xbfc70000, 0xd7610002,
> +	0x0001027a, 0xbefa5083,
> +	0xbfc70000, 0xd7610002,
> +	0x0001047a, 0xbefa5084,
> +	0xbfc70000, 0xd7610002,
> +	0x0001067a, 0xbefa5085,
> +	0xbfc70000, 0xd7610002,
> +	0x0001087a, 0xbefa5086,
> +	0xbfc70000, 0xd7610002,
> +	0x00010a7a, 0xbefa5087,
> +	0xbfc70000, 0xd7610002,
> +	0x00010c7a, 0xbefa5088,
> +	0xbfc70000, 0xd7610002,
> +	0x00010e7a, 0xbefa5089,
> +	0xbfc70000, 0xd7610002,
> +	0x0001107a, 0xbefa508a,
> +	0xbfc70000, 0xd7610002,
> +	0x0001127a, 0xbefa508b,
> +	0xbfc70000, 0xd7610002,
> +	0x0001147a, 0xbefa508c,
> +	0xbfc70000, 0xd7610002,
> +	0x0001167a, 0xbefa508d,
> +	0xbfc70000, 0xd7610002,
> +	0x0001187a, 0xbefa508e,
> +	0xbfc70000, 0xd7610002,
> +	0x00011a7a, 0xbefa508f,
> +	0xbfc70000, 0xd7610002,
> +	0x00011c7a, 0xbefa5090,
> +	0xbfc70000, 0xd7610002,
> +	0x00011e7a, 0xee0a4076,
> +	0x010c0000, 0x00008000,
> +	0xb8f03b05, 0x80708170,
> +	0xbf0d9973, 0xbfa20002,
> +	0x84708970, 0xbfa00001,
> +	0x84708a70, 0xbef90080,
> +	0xbefd0080, 0xbf800000,
> +	0xbe804100, 0xbe824102,
> +	0xbe844104, 0xbe864106,
> +	0xbe884108, 0xbe8a410a,
> +	0xbe8c410c, 0xbe8e410e,
> +	0xd7610002, 0x0000f200,
> +	0x80798179, 0xd7610002,
> +	0x0000f201, 0x80798179,
> +	0xd7610002, 0x0000f202,
> +	0x80798179, 0xd7610002,
> +	0x0000f203, 0x80798179,
> +	0xd7610002, 0x0000f204,
> +	0x80798179, 0xd7610002,
> +	0x0000f205, 0x80798179,
> +	0xd7610002, 0x0000f206,
> +	0x80798179, 0xd7610002,
> +	0x0000f207, 0x80798179,
> +	0xd7610002, 0x0000f208,
> +	0x80798179, 0xd7610002,
> +	0x0000f209, 0x80798179,
> +	0xd7610002, 0x0000f20a,
> +	0x80798179, 0xd7610002,
> +	0x0000f20b, 0x80798179,
> +	0xd7610002, 0x0000f20c,
> +	0x80798179, 0xd7610002,
> +	0x0000f20d, 0x80798179,
> +	0xd7610002, 0x0000f20e,
> +	0x80798179, 0xd7610002,
> +	0x0000f20f, 0x80798179,
> +	0xbf06a079, 0xbfa10009,
> +	0x80767074, 0x82778075,
> +	0xee0a4076, 0x010c0000,
> +	0x00000000, 0x8070ff70,
> +	0x00000080, 0xbef90080,
> +	0x7e040280, 0x807d907d,
> +	0xbf0aff7d, 0x00000060,
> +	0xbfa2ffb9, 0xbe804100,
> +	0xbe824102, 0xbe844104,
> +	0xbe864106, 0xbe884108,
> +	0xbe8a410a, 0xd7610002,
> +	0x0000f200, 0x80798179,
> +	0xd7610002, 0x0000f201,
> +	0x80798179, 0xd7610002,
> +	0x0000f202, 0x80798179,
> +	0xd7610002, 0x0000f203,
> +	0x80798179, 0xd7610002,
> +	0x0000f204, 0x80798179,
> +	0xd7610002, 0x0000f205,
> +	0x80798179, 0xd7610002,
> +	0x0000f206, 0x80798179,
> +	0xd7610002, 0x0000f207,
> +	0x80798179, 0xd7610002,
> +	0x0000f208, 0x80798179,
> +	0xd7610002, 0x0000f209,
> +	0x80798179, 0xd7610002,
> +	0x0000f20a, 0x80798179,
> +	0xd7610002, 0x0000f20b,
> +	0x80798179, 0xbefe00ff,
> +	0x0000ffff, 0x80767074,
> +	0x82778075, 0xee0a4076,
> +	0x010c0000, 0x00000000,
> +	0xbefe00c1, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20002, 0xbeff0080,
> +	0xbfa00001, 0xbeff00c1,
> +	0xb8fb4306, 0x8b7bc17b,
> +	0xbfa10042, 0x8b7aff6d,
> +	0x80000000, 0xbfa1003f,
> +	0x847b8a7b, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0x8070ff70, 0x00000200,
> +	0x8070ff70, 0x00000200,
> +	0xd71f0000, 0x000100c1,
> +	0xd7200000, 0x000200c1,
> +	0x16000084, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbefd0080, 0xbfa20015,
> +	0xbe8300ff, 0x00000080,
> +	0xbf800000, 0xbf800000,
> +	0xbf800000, 0xd8d80000,
> +	0x01000000, 0xbf8a0000,
> +	0x80767074, 0x82778075,
> +	0xee0a4076, 0x008c0000,
> +	0x00000000, 0x807d037d,
> +	0x80700370, 0xd5250000,
> +	0x0001ff00, 0x00000080,
> +	0xbf0a7b7d, 0xbfa2fff1,
> +	0xbfa00014, 0xbe8300ff,
> +	0x00000100, 0xbf800000,
> +	0xbf800000, 0xbf800000,
> +	0xd8d80000, 0x01000000,
> +	0xbf8a0000, 0x80767074,
> +	0x82778075, 0xee0a4076,
> +	0x008c0000, 0x00000000,
> +	0x807d037d, 0x80700370,
> +	0xd5250000, 0x0001ff00,
> +	0x00000100, 0xbf0a7b7d,
> +	0xbfa2fff1, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20004,
> +	0xbef000ff, 0x00000200,
> +	0xbeff0080, 0xbfa00003,
> +	0xbef000ff, 0x00000400,
> +	0xbeff00c1, 0xb8fb3b05,
> +	0x807b817b, 0x847b827b,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa2001b,
> +	0xbefd0084, 0xbf0a7b7d,
> +	0xbfa10032, 0x7e008700,
> +	0x7e028701, 0x7e048702,
> +	0x7e068703, 0x80767074,
> +	0x82778075, 0xee0a4076,
> +	0x000c0000, 0x00000000,
> +	0xee0a4076, 0x008c0000,
> +	0x00008000, 0xee0a4076,
> +	0x010c0000, 0x00010000,
> +	0xee0a4076, 0x018c0000,
> +	0x00018000, 0x807d847d,
> +	0x8070ff70, 0x00000200,
> +	0xbf0a7b7d, 0xbfa2ffe9,
> +	0xbfa0001a, 0xbefd0084,
> +	0xbf0a7b7d, 0xbfa10017,
> +	0x7e008700, 0x7e028701,
> +	0x7e048702, 0x7e068703,
> +	0x80767074, 0x82778075,
> +	0xee0a4076, 0x000c0000,
> +	0x00000000, 0xee0a4076,
> +	0x008c0000, 0x00010000,
> +	0xee0a4076, 0x010c0000,
> +	0x00020000, 0xee0a4076,
> +	0x018c0000, 0x00030000,
> +	0x807d847d, 0x8070ff70,
> +	0x00000400, 0xbf0a7b7d,
> +	0xbfa2ffe9, 0xbfa00184,
> +	0xbef4007e, 0x8b75ff7f,
> +	0x01ffffff, 0xbef1007f,
> +	0xb8f20742, 0x84729972,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa10044, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef4306,
> +	0x8b6fc16f, 0xbfa10039,
> +	0x846f8a6f, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0x8078ff78, 0x00000200,
> +	0x8078ff78, 0x00000200,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xd71f0001, 0x000100c1,
> +	0xd7200001, 0x000202c1,
> +	0x30020282, 0xbfa20012,
> +	0x80767874, 0x82778075,
> +	0xee0a0076, 0x000c0000,
> +	0x00000000, 0xbf8a0000,
> +	0xd8340000, 0x00000001,
> +	0xd5250001, 0x0001ff01,
> +	0x00000080, 0x807dff7d,
> +	0x00000080, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2ffef, 0xbfa00011,
> +	0x80767874, 0x82778075,
> +	0xee0a0076, 0x000c0000,
> +	0x00000000, 0xbf8a0000,
> +	0xd8340000, 0x00000001,
> +	0xd5250001, 0x0001ff01,
> +	0x00000100, 0x807dff7d,
> +	0x00000100, 0x8078ff78,
> +	0x00000100, 0xbf0a6f7d,
> +	0xbfa2ffef, 0xbef80080,
> +	0xbefe00c1, 0x857d9972,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20002, 0xbeff0080,
> +	0xbfa00001, 0xbeff00c1,
> +	0xb8ef3b05, 0x806f816f,
> +	0x846f826f, 0x857d9972,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa2002c, 0xbeee0078,
> +	0x8078ff78, 0x00000200,
> +	0xbefd0084, 0x80767874,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00008000, 0xee0a0076,
> +	0x000c0002, 0x00010000,
> +	0xee0a0076, 0x000c0003,
> +	0x00018000, 0xbf8a0000,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000200, 0xbf0a6f7d,
> +	0xbfa2ffe8, 0x80766e74,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00008000, 0xee0a0076,
> +	0x000c0002, 0x00010000,
> +	0xee0a0076, 0x000c0003,
> +	0x00018000, 0xbf8a0000,
> +	0xbfa0002d, 0xbeee0078,
> +	0x8078ff78, 0x00000400,
> +	0xbefd0084, 0xbf0a6f7d,
> +	0xbfa10018, 0x80767874,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00010000, 0xee0a0076,
> +	0x000c0002, 0x00020000,
> +	0xee0a0076, 0x000c0003,
> +	0x00030000, 0xbf8a0000,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000400, 0xbf0a6f7d,
> +	0xbfa2ffe8, 0x80766e74,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00010000, 0xee0a0076,
> +	0x000c0002, 0x00020000,
> +	0xee0a0076, 0x000c0003,
> +	0x00030000, 0xbf8a0000,
> +	0xb8f83b05, 0x80788178,
> +	0xbf0d9972, 0xbfa20002,
> +	0x84788978, 0xbfa00001,
> +	0x84788a78, 0x8078ff78,
> +	0x00000200, 0x80f8ff78,
> +	0x00000060, 0x80767874,
> +	0x82778075, 0xbefd00ff,
> +	0x0000006c, 0xf460403b,
> +	0xf8000000, 0xbf8a0000,
> +	0x80fd847d, 0xbf800000,
> +	0xbe804300, 0xbe824302,
> +	0x80f6a076, 0x82f78077,
> +	0xf460603b, 0xf8000000,
> +	0xbf8a0000, 0x80fd887d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0x80f6c076,
> +	0x82f78077, 0xf460803b,
> +	0xf8000000, 0xbf8a0000,
> +	0x80fd907d, 0xbf800000,
> +	0xbe804300, 0xbe824302,
> +	0xbe844304, 0xbe864306,
> +	0xbe884308, 0xbe8a430a,
> +	0xbe8c430c, 0xbe8e430e,
> +	0xbf06807d, 0xbfa1ffef,
> +	0xb980f801, 0x00000000,
> +	0xb8f83b05, 0x80788178,
> +	0xbf0d9972, 0xbfa20002,
> +	0x84788978, 0xbfa00001,
> +	0x84788a78, 0x8078ff78,
> +	0x00000200, 0x80767874,
> +	0x82778075, 0xbeff0071,
> +	0xf4601bfb, 0xf8000000,
> +	0xf4601b3b, 0xf8000004,
> +	0xf4601b7b, 0xf8000008,
> +	0xf4601c3b, 0xf800000c,
> +	0xf4601c7b, 0xf8000010,
> +	0xf4601ebb, 0xf8000014,
> +	0xf4601efb, 0xf8000018,
> +	0xf4601e7b, 0xf800001c,
> +	0xf4601cfb, 0xf8000020,
> +	0xf4601bbb, 0xf8000024,
> +	0xbf8a0000, 0xb96ef814,
> +	0xf4601bbb, 0xf8000028,
> +	0xbf8a0000, 0xb96ef815,
> +	0xf4601bbb, 0xf800002c,
> +	0xbf8a0000, 0xb96ef812,
> +	0xf4601bbb, 0xf8000030,
> +	0xbf8a0000, 0xb96ef813,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa10022, 0xf4601bbb,
> +	0xf8000038, 0xbf8a0000,
> +	0xbf0d806e, 0xbfa1001d,
> +	0x856e906e, 0x8b6e6e6e,
> +	0xbfa10003, 0xbe804ec1,
> +	0x816ec16e, 0xbfa0fffb,
> +	0xbef800ff, 0x00000080,
> +	0xbefd0081, 0xf4601bbb,
> +	0xf0000000, 0xbfc70000,
> +	0x80788478, 0x937eff6e,
> +	0x00070004, 0x847e907e,
> +	0x8c7d7e7d, 0xbe80517d,
> +	0x917dff7d, 0x007f0000,
> +	0x856e906e, 0x8b6e6e6e,
> +	0xbfa10003, 0xbe804e7d,
> +	0x816ec16e, 0xbfa0fffb,
> +	0x807d817d, 0xbf08907d,
> +	0xbfa1ffec, 0xf4601bbb,
> +	0xf800003c, 0xbfc70000,
> +	0xbf0d806e, 0xbfa1000c,
> +	0xbf0d9a7f, 0xbfa10002,
> +	0xbf068180, 0xbe804fc4,
> +	0xbf94fffc, 0xbfa10006,
> +	0x856e906e, 0x8b6e6e6e,
> +	0xbfa10003, 0xbe804ec3,
> +	0x816ec16e, 0xbfa0fffb,
> +	0xf4601bbb, 0xf8000040,
> +	0xbfc70000, 0xb96ef81a,
> +	0xbefd006f, 0xbefe0070,
> +	0xbeff0071, 0xb979f822,
> +	0xb97b2011, 0x857b867b,
> +	0xb97b0191, 0x857b827b,
> +	0xb97bba11, 0xb973f801,
> +	0xb8ee3b05, 0x806e816e,
> +	0xbf0d9972, 0xbfa20002,
> +	0x846e896e, 0xbfa00001,
> +	0x846e8a6e, 0x806eff6e,
> +	0x000001c0, 0x806e746e,
> +	0x826f8075, 0xf4605c37,
> +	0xf8000010, 0xf4605d37,
> +	0xf8000020, 0xf4601e77,
> +	0xf8000034, 0xbf8a0000,
> +	0x856e9677, 0xb96e04a1,
> +	0x856e9577, 0xb96e0421,
> +	0x856e8e77, 0xb96e3021,
> +	0x8b6dff6d, 0x01ffffff,
> +	0x8bfe7e7e, 0x8bea6a6a,
> +	0xb97af804, 0xb8eef802,
> +	0xbf0c8b6e, 0xbfa20003,
> +	0xbe804fc2, 0xbf94fffe,
> +	0xbfa10001, 0xbe804ec4,
> +	0xbf94fffc, 0x857a897a,
> +	0xb97a0244, 0xbe804a6c,
> +	0xb8eef802, 0xbf0c8b6e,
> +	0xbfa20003, 0xbe804fc2,
> +	0xbf94fffe, 0xbfa10001,
> +	0xbe804ec4, 0xbf94fffc,
> +	0xbfb10000, 0xbf9f0000,
> +	0xbf9f0000, 0xbf9f0000,
> +	0xbf9f0000, 0xbf9f0000,
> +};
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index b5af2c97a091..1e248af0e9e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -28,23 +28,26 @@
>    */
>   
>   #define CHIP_GFX12 37
> -#define CHIP_GC_12_0_3 38
> -
> -#define HAVE_XNACK (ASIC_FAMILY == CHIP_GC_12_0_3)
> -#define HAVE_57BIT_ADDRESS (ASIC_FAMILY == CHIP_GC_12_0_3)
> -#define HAVE_BANKED_VGPRS (ASIC_FAMILY == CHIP_GC_12_0_3)
> -#define NUM_NAMED_BARRIERS (ASIC_FAMILY == CHIP_GC_12_0_3 ? 0x10 : 0)
> -#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
> -#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
> +#define CHIP_GC_12_0_3_REV_0 38
> +#define CHIP_GC_12_0_3_REV_1 39
> +
> +#define HAVE_XNACK (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define HAVE_57BIT_ADDRESS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define HAVE_BANKED_VGPRS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define NUM_NAMED_BARRIERS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0 ? 0x10 : 0)
> +#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
>   #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
> -#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
> +#define HAVE_VOP3PX_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3_REV_0)
> +#define HAVE_VGPR_MSB_FIXUP (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define HAVE_INSTRUCTION_FIXUP (HAVE_VOP3PX_FIXUP || HAVE_VGPR_MSB_FIXUP)

The instruction fixup seems to be doing more than either VOP3PX_FIXUP or 
VGPR_MSB_FIXUP.  The fixup_instruction function is more than the union 
of the code enabled by those two flags.

Would seem more consistent to just define this as "ASIC_FAMILY >= 
CHIP_GC_12_0_3_REV_0".  WDYT?

Other than this minor remark (which would result in the exact same 
binary), this looks reasonable to me.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

>   
>   #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
>   #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
> -#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY >= CHIP_GFX12)
> -#define WAVE32_ONLY (ASIC_FAMILY == CHIP_GC_12_0_3)
> -#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3)
> -#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY == CHIP_GC_12_0_3)
> +#define HAVE_HT_TRAP_ID_WA 1
> +#define WAVE32_ONLY (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
> +#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
>   
>   #if HAVE_XNACK && !WAVE32_ONLY
>   # error
> @@ -76,7 +79,7 @@ var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
>   
> -#if ASIC_FAMILY < CHIP_GC_12_0_3
> +#if ASIC_FAMILY < CHIP_GC_12_0_3_REV_0
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
>   #else
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
> @@ -707,7 +710,7 @@ L_SAVE_HWREG:
>   	write_hwreg_to_v2(s_save_tmp)
>   #endif
>   
> -#if ASIC_FAMILY >= CHIP_GC_12_0_3
> +#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
>   	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCHED_MODE)
>   	write_hwreg_to_v2(s_save_tmp)
>   #endif
> @@ -1281,7 +1284,7 @@ L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
>   L_SKIP_CLUSTER_BARRIER_RESTORE:
>   #endif
>   
> -#if ASIC_FAMILY >= CHIP_GC_12_0_3
> +#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
>   	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x40
>   	s_wait_kmcnt	0
>   	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
> @@ -1393,7 +1396,7 @@ function get_sgpr_size_bytes
>   end
>   
>   function get_hwreg_size_bytes
> -#if ASIC_FAMILY >= CHIP_GC_12_0_3
> +#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
>   	return 512
>   #else
>   	return 128
> @@ -1550,6 +1553,7 @@ function fixup_instruction
>   	// Instruction is 1 DWORD otherwise
>   
>   L_FIXUP_ONE_DWORD:
> +#if HAVE_VGPR_MSB_FIXUP
>   	// Check if TTMP15 contains the value for S_SET_VGPR_MSB instruction
>   	s_and_b32	ttmp10, ttmp15, 0xffff0000				// Check encoding in upper 16 bits
>   	s_cmp_eq_u32	ttmp10, 0xbf860000					// Check if SOPP (9b'10_1111111) and S_SET_VGPR_MSB (7b'0000110)
> @@ -1560,6 +1564,7 @@ L_FIXUP_ONE_DWORD:
>   	s_lshr_b32	ttmp13, ttmp13, 6					// Shift SIMM[13:8] into 7:2, Src2, Src1, Src0
>   	s_or_b32	ttmp10, ttmp10, ttmp13					// Src2, Src1, Src0, Dst --> format in MODE register
>   	s_setreg_b32	hwreg(HW_REG_WAVE_MODE, 12, 8), ttmp10			// Write value into MODE[19:12]
> +#endif
>   	s_branch	L_FIXUP_DONE
>   
>   L_FIXUP_NOT_VOP12C:
> @@ -1586,10 +1591,12 @@ L_FIXUP_NOT_VOP12C:
>   	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
>   	// Check if we are in the middle of VOP3PX.
>   	s_and_b32	ttmp13, ttmp14, 0xffff0000				// Bits 31:16
> +#if HAVE_VOP3PX_FIXUP
>   	s_cmp_eq_u32	ttmp13, 0xcc330000					// If 31:16 = 0xcc33, this is 8 bytes past VOP3PX
>   	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
>   	s_cmp_eq_u32	ttmp13, 0xcc880000					// If 31:16 = 0xcc88, this is 8 bytes past VOP3PX
>   	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
> +#endif
>   	// Might be in VOP3P, but we must ensure we are not VOP3PX2
>   	s_cmp_eq_u32	ttmp13, 0xcc350000					// If 31:16 = 0xcc35, this is VOP3PX2
>   	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
> @@ -1651,10 +1658,12 @@ L_FIXUP_THREE_DWORD:
>   	s_mov_b32	ttmp15, ttmp3						// Move possible S_SET_VGPR_MSB into ttmp15
>   	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
>   
> +#if HAVE_VOP3PX_FIXUP
>   L_FIXUP_VOP3PX_MIDDLE:
>   	s_sub_co_u32	ttmp0, ttmp0, 8						// Rewind PC 8 bytes to beginning of instruction
>   	s_sub_co_ci_u32	ttmp1, ttmp1, 0
>   	s_branch	L_FIXUP_TWO_DWORD					// 2 DWORD inst (2nd half of a 4 DWORD inst)
> +#endif
>   
>   L_FIXUP_DONE:
>   	s_wait_kmcnt	0							// Ensure load of ttmp2 and ttmp3 is done
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0f96c9e3fa4d..edafbd9377b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -564,11 +564,17 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
>   					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
> +		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(12, 1, 0) &&
> +			(kfd->adev->rev_id & 0xF) == 0) {
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_0_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
> +			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_0_hex;
> +			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);
>   		} else {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex)
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex)
>   					     > KFD_CWSR_TMA_OFFSET);
> -			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_hex;
> -			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_hex);
> +			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_1_hex;
> +			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);
>   		}
>   
>   		kfd->cwsr_enabled = true;

