Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD67E8B391
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C46510E6DD;
	Wed,  4 Feb 2026 03:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oCj79epb";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23C410E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQef0pOxrLg8zooamCii/G/Wp3xERnBQ/Qz2G5c+1BBh3sTgcBQonHMPk6VCczF6q2gAPMT+jSYebB1KieAyekB/ejaD9/cAuRRg116Q0npuv7qUZaDnYDaf68a+YThuluLFLYC6/niZD5FIYrNWjN28feXTBxkRuCBSnXFljacA7Q2P36d72dR3XWoKZxpqyC6gONv1KAtcng8YAV8PEnAhDWSlV+tUp3PwOENsQY5hhnU12++2ZQ8UazfaU6KXMw914UzExze75plL4SKu96zOXTt9lYSIuoDbmKwrebk+MbUg4wiITkDblNBPGoob7hx1LKcUSfQVsHWKF36lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsaWBhpZy+HEY/+Tedep9HKfa1d4zssOu3X685HI1pE=;
 b=Tq5lo9LhX/vEKMhvjRKyCPhXTwVOEWgyGnzS6Jh0rttyOoJhtIZn2byYznEzyk0gTcZdyBDIYhBx3uE+d9JfigDwBXdP/ySDosJwIoYcrQ2oBN/uvu9B2wtm/CuLkto3Sk8jpKPDblBwcHQGXk8FcAZXBZoWcztJSsOS+o9gCOrV9stCqNy5/qOTCNiS2BJ0l9LjAeCfLhw480By9vXm/PWIpLZQN3T8vHow5uJGRQ9vHT3KZ8702cm1ZkcN+7fJJOwT6HEW01f0ONhrBerk7EBdhoZAbX3vD9tmhfnDi8u6K+KErwwHtIr9oEIEP45lPD2aggqaJaKRtFyCUmNatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsaWBhpZy+HEY/+Tedep9HKfa1d4zssOu3X685HI1pE=;
 b=oCj79epbqop47tUqLevmlqYYTtIqi2ZsgzmGmGza2ZlwKox9ZCYljaLWWBp/qVGtxOELqWEih4aDxAjEho8BhNqklh8CAY2RjSlZ9XbSfDrXJfHNA3B/Bs2STh/9tlba0IZsXvl3ro1ZKaL04vrL3bhBGdbqQRk8lKgi7KzFZvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 03:52:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 03:52:07 +0000
Message-ID: <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
Date: Wed, 4 Feb 2026 09:22:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260204034732.187325-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204034732.187325-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::29) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0595bc56-2f37-45f2-ab17-08de63a0c45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU9XMmd3MmVkR0prV3FRNHF3bkVUMFVzMC9iV1Yxbmltak02S1Q3ZTNYTnEx?=
 =?utf-8?B?aHM0MlpTODdxMGxjMjFTU1g4b2svMVlJZ1c1ekJGckl1aVZZdDFhcEY1bDgx?=
 =?utf-8?B?ckZJK0NYbU1iVHYydHduelgrbFhwU1JVRjdRTVBqUmlWK0grMmpYeldYeU5y?=
 =?utf-8?B?eXI4UzNsMEFJSW5TNWc3bUdpNGM2RkJsdkhYVklWVVdTbi8xRFJVOG5HOHNZ?=
 =?utf-8?B?L1o5L0JtSmtOaG9IRi8ydkcwaDFqNzVqSjhidG1qOVhRaWM3eXl4WnZXSFFp?=
 =?utf-8?B?TDRHeWVvOVlJcE1LUVIyeDNBZFViRFFFTFFCNStZVG9mSzEydkZEMG00Zlds?=
 =?utf-8?B?S1h6RUZBN1p0WEtCcTAxRHBDUGhsbjkrVE5idCtrdjVTSWJ3RTJvZC9peHBB?=
 =?utf-8?B?TkhFQkdnMWdGWlNRZEFpSlRPZVRqY2ZGWUdJelVQa2xhY2RDSDlJTForT1JD?=
 =?utf-8?B?VjF4Ulc5Nm1URUJ0UmlucVJXTm1telFXc1VIV0Y0R3RTNVNDdjM2OUhMaVVZ?=
 =?utf-8?B?MmZoUExqSkVDcnNHVU5HeXl0Y0s3cndGbUlIamRDZDF0R2IzSkh5SUQ3RnNP?=
 =?utf-8?B?bVI2bk16SFBlWWhPcWZGdzV3bmtYcW1yZHNXRHZqZ2RsajA2eVk0S0U1M0hu?=
 =?utf-8?B?M1lidUVSUis0MnNDTTlGVFJaZjZISjgrd1piVVRJRmo4RjNveGExd2VXRVBx?=
 =?utf-8?B?SnN1L3ltV21pN1NGS2VLWCtIZmRxY0kxcDV5NnFwQ29vN3FOK0ZGeTVzUFdt?=
 =?utf-8?B?c1R3bUhoSk9GZzE1TFRpNC9ucDJldUs1eWlMam5wNHlvSzIzQzd1VjYwOXhi?=
 =?utf-8?B?Tnl4cXU1SW5peGRxbUhMbFRNODBKR2t2TzBhOU9CanFqcTdlN2ZIWDVnVDdT?=
 =?utf-8?B?cWlINU9jWm1vYmdoSzRqaXE0dHBtQUJkSVBzWGc5SmpIcHc0VjdzWWlKcllN?=
 =?utf-8?B?c0tockI4TDZmSHVTV2lFVE0vRDlDTzNKTERqYWlURUtXendGREFIdVZXZGFz?=
 =?utf-8?B?MEE0RHk3UzdPNUF0b2NxK2h6M2tUM2lDdDNUbEo4QmRrZHNTRmhoRnBOYkQr?=
 =?utf-8?B?ZGdmb2NReDBrQW90M2Fkb0l4WFBjelY4N3I2cXNwY25xVkVvY1dYcGZVRk5R?=
 =?utf-8?B?bjlNY1RqRytzN0Y1UE01amhhNEwvNkdMYkcvdjc4UVFLTHZ6bGxxektiNVk4?=
 =?utf-8?B?TGpwVW90Zy9lTlhCOW1GMVRtcllYK2F0QVRqMU1lVzNiaTNDczIwM1ZWUmRX?=
 =?utf-8?B?bVpFL3FMQ1ZFWkZLSGRmc3FiNm9YVzllYXRvNGhZd0FMT0d4UVZ5clZydno2?=
 =?utf-8?B?aXhFS1ZwKzZJTjdkR1QvbnMwWFFjSlRielhDTm9YVjJLSGZhZUVhbUZzb0Vl?=
 =?utf-8?B?R3V0QUk0WURmWndxUzlUTVNmaytRMVh4dWxsbXZNci9aeUVUcFRBTERkOFg2?=
 =?utf-8?B?Q2hHeEpvY1I1VzEyeUhiWTRlQVV2clJWbkFTSDJlelE0TnQ5RHI2YzJUNUcz?=
 =?utf-8?B?VWdqcVY4ZXBPdXcrK1ErY3hZdEtDYW1FRFpGUGdLTWVPTW1zS0RPQTh2WGNL?=
 =?utf-8?B?eTRPcHdETXVCbzlzUmVmcnkwVWFVeHpQV1l6OVFOdG90S2JCKyt2SG9wQ084?=
 =?utf-8?B?R01USkgrTElZM2tmL1k5OTl6NVY3ZEt6V3lkSnNUbFh1TXoyODc1RzBkVU9m?=
 =?utf-8?B?QW9KWllOVUpyNTZmb3Q1dWVBZVRJbXNSQmZyaUVnZzZ6Qkx1V1l2UGZrdlBX?=
 =?utf-8?B?QU1IRkVMWHdLd3YrSlhpSG5qenRmb0Uwc0Nlb1NDRWJIYXgvZ1dBL1d2OHBp?=
 =?utf-8?B?bGxvVGVKVmp2cTVIZjFsdXBhQmRabjlQRWxMelVLY2YyNWJ5MmZXTEtPMjhX?=
 =?utf-8?B?QnNkOW5nWDR5clkzTHRWWU5rVTRPUW02My9JTmtCTjJ2TENRdUZXQ2daeFhh?=
 =?utf-8?B?T0xJaHlnMkwvYktHZ2VLVlFqZ1pEeWk1REc0UmpsbzhLMGdGYmp3RnBtbU9F?=
 =?utf-8?B?ZE8yMnhCeERQZllMRzZuN01HT05zVnRBeXhSY3FmYm5YSTRFTmp4ajNvZ0Rh?=
 =?utf-8?B?WlhpcGlaZWdOYlBLT0JGbDRjRDhIaFA2SlBWNmptaWNrU1puNzdMWU05RDdi?=
 =?utf-8?Q?wJws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1FzN2U1NmU1UTd1ekhKNXVIUTJ6QytRN2pmS3EzM2s5T09rcm9aOVkzQUFM?=
 =?utf-8?B?RFVmWFVzUWc1R2JzWUVjd0pERFVmTnhkQytBWmlVZ1k2UExpUDNxNktseHcx?=
 =?utf-8?B?eDBzakc0dGFnM3M1b3RaYmtJeGZ6RUJBUitIb1VuUzlDcnVoRWlEaUZlMkMz?=
 =?utf-8?B?RTRqZzg0NXlxSkg2QVcrcVFSWnozcVBscnpocVBrakFpTUpHRkljNXpUOStF?=
 =?utf-8?B?a2l0NmVIUWRQYk90OEpBc2dWeVk2TXBXRHEvcGxPcVVMM0RGUFlCVS9XYmEz?=
 =?utf-8?B?NUV2bXZDOExGK2Q5dUhBd053Y1NCQnF4Z0FDOUNiTHI2RUFSY28vc1UyYmhH?=
 =?utf-8?B?czBPWWdZQk1qYXBickVpSG51ajI2K2NSRmQwUmxjcDVQZVVPMi9JTlhkOERw?=
 =?utf-8?B?UnNSVndObmFLQk1ibHlEL3Mva1Y3SklVczNoSmlhaHZQd1pFYWE3cTlLU3ov?=
 =?utf-8?B?bTlzOTJtbWZGMDdncFo5TkZjOVFnY1c4RmpkcEtybmRGYmRCeDJXRlo1cGx0?=
 =?utf-8?B?UjdYZzlMVjB1UzdGWnBBcWR0azB6YmlKdkZ1Mkl4dnlrZ1pZclhJdm9RWDZy?=
 =?utf-8?B?Wldrdkw0R3drbHhSWE9LMkM0ck9oK3ZhaldXSVBOZCtsdERUR2M5OGMvTklB?=
 =?utf-8?B?ZlJSU2hxMWxiaU9leWIxdFNaZks0Y1pIUThEWUlmNkw3M09mZmordXNKV2t2?=
 =?utf-8?B?d2ZJTUIwd0dGM042SlVmaTJ3WkFlOVJtWXlPWERhQ3BoR25GeVowWjNvTXNN?=
 =?utf-8?B?VFIxaFJ4Vkt6a2tIeEs3QlFWZHN5Zjgzb0R4N1FXKzliNjRUL3ZwUjRzeHl6?=
 =?utf-8?B?ak1CUXl4cWplSUtvaVRoRUxOZGpvQ3A2RHh1WWRKWGdDaW9KT2dmL00wNzAx?=
 =?utf-8?B?REw1RjMxdEtxK203Q0syUnRDQ0htOVdHbms1ZmNma3RjUTFwcHFxSEhaV2JJ?=
 =?utf-8?B?eFhuZTkxajJHbTJzZWhOMG9sMm0yYmxiMnU1SUY3WWIyNlB5cVRMZmRDQVhK?=
 =?utf-8?B?d1BVc0h5U2t4Wk85cldHL0lZSEZidkNGU3FCdkpQWUZ5amtNdmV5K2JadEhG?=
 =?utf-8?B?ak5heG00eDNtK3JMRmVUZENzMTNESlRzQXlqeUVSaVlnUGE4a1U2M0F3VU9u?=
 =?utf-8?B?ZEM4Z0xkT2xJa2tWK2N1YnhRYnFhbFRscTdqUDhuNU5oSURObXpsamFwZ2xv?=
 =?utf-8?B?anBTeFZZY1BlbjQ1Sk9PNGhvMHZoZEp4blJDOHJGL3FCT1VvMnUybjRWeE1x?=
 =?utf-8?B?NXp3ZU9pSlRHd1Y5QTN1cGR6amxVTTdwUXBPNzhzOCs0UWhHWVB1U0cxOFd1?=
 =?utf-8?B?ZTI2Uks3cE1OTkU4QnZsR2dXdEd5Mlo0L2h1cThZNzZEa0JvaG96VVQycjVl?=
 =?utf-8?B?RFNmem9SdUduRTg2SmtvQlp6VjF3Nnc2UFQ4VFNoTEpnRXFRWFR5aitML2hv?=
 =?utf-8?B?SEprdTB3ZE9qeTNTQ3FBK09NMFYwYzJoaW1jOWk3ei9ldEdqVnp6ODFxSFAx?=
 =?utf-8?B?YVlqaWRURFJNdWE2YTRRY2NKOEtmWFN3VEdyT21vN0Z4b3g4OEpQaFZCUWNl?=
 =?utf-8?B?Z3B3SlkwMjFnVTM3NjJqMHoxK1BpNnYwU1JQSHcrMmdZSWlLN2tpWElsRzl1?=
 =?utf-8?B?eFM2THp3SGg0dlVYbE1PbFNiQ3RSQjhYYlY0b1o4TVFhanh1bFg0NDNhYXc4?=
 =?utf-8?B?dW9wcWNXSFZoclR6aWpKVkdqR2UzTVhoS0N5U1hZRlQxWGwvMEptUlpGYlQz?=
 =?utf-8?B?Q3FVTTRYdGNDc08zd2kwbWxVcG51bUQyTzJxUXUvYkF6S1lDN0xOek41TndT?=
 =?utf-8?B?aW5wc3k4UGFHNkN0MDJ0VFN1aXB6S3RBbjcvckV2MUNSbjY3akNjUXQwK2tB?=
 =?utf-8?B?SjZONGVwYi9TZW9Ea2dCeXA2b0NNYlhpRERTR2YvdkpCRDJpSWd1L2J4bmJG?=
 =?utf-8?B?VmoxYmJpZmMrSWNWQ0VEendHY3BZZHgrZXJKVWJVZzE2RFFPc3NadVZsRUw3?=
 =?utf-8?B?b1h6STdxbUhRQUYxZm1ZQ0QzNXJpcXExWWtWUDJtbW81UDYzVWRzUzhucUpM?=
 =?utf-8?B?bUFLS2RmYUtZK0ZKYW5sZjkwekxKQWFpNTM3d21xK1dxZy9WT1Y5Q2FmeDhs?=
 =?utf-8?B?QzlOcWUxck13T1RpZ0xkbnYza0pKdWZSVzd6V2dCbEQ4L0N3N0grUFBoWmI4?=
 =?utf-8?B?R01KV284eEZLUU9pZ3NDZ01NV1crZ1M2aHVOdEQ0bW4yci8xbHpqaEkvditq?=
 =?utf-8?B?dDFZUSs1b0RtSzA3ajJjMTRWdVcxU25QZ2Nwa1YxaC83cGhZbnlUWVFyTkR5?=
 =?utf-8?B?OGljSXB1Q3FEemw4ZGhnYmFWd3B4Z1luOUNJOHZIU1RoWWRNRVNqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0595bc56-2f37-45f2-ab17-08de63a0c45a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:52:07.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRmbZL2xdp1pu6S/eguyqlghTkxoMaGeHLDhzVtMsdUpCV1qJNahP6Mk5+daKPZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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



On 04-Feb-26 9:17 AM, Yang Wang wrote:
> add missing performance level AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM in smu13,14,15.
> 
> kernel dmesg log:
> [1217924.810528] amdgpu 0000:44:00.0: amdgpu: Invalid performance level 512
> [1217924.810537] amdgpu 0000:44:00.0: amdgpu: Failed to set performance level 512
> 
> Fixes: 6be6424684cb ("drm/amd/pm: Enable performance determinism on aldebaran")
> 

Determinism level is only available for specific SOCs, so the the error 
message is still valid.

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 63a65ea802fd..d17d6cd71028 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1659,6 +1659,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
>   		break;
>   	case AMD_DPM_FORCED_LEVEL_MANUAL:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> +	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>   		return 0;
>   	default:
>   		dev_err(adev->dev, "Invalid performance level %d\n", level);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 7dc6687c3693..68ecba0d5e0b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1321,6 +1321,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
>   		break;
>   	case AMD_DPM_FORCED_LEVEL_MANUAL:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> +	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>   		return 0;
>   	default:
>   		dev_err(adev->dev, "Invalid performance level %d\n", level);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..1860bd0f1091 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1210,6 +1210,7 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
>   		break;
>   	case AMD_DPM_FORCED_LEVEL_MANUAL:
>   	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> +	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>   		return 0;
>   	default:
>   		dev_err(adev->dev, "Invalid performance level %d\n", level);

