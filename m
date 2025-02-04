Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B785C0219F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7851310E6AF;
	Tue,  4 Feb 2025 15:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLlv+HB9";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8FA10E6AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMOR4cKj2FL/iUVzSyFx5R9gv3pcMsdl47v/f8lKk5bIpr+H+ML81/kHXr7sl1C070IonmJqrTSIkvxXXlqiZ7a8EqZ8eTbLW1e61DDD9N2OrvjWFXKlViW17QlFA8TQcSgrehc+vuPbKIZ0s8v16sOISTszXXfkrs9D2Wvu+Mc6JMrgeVUX7gUvt2Od8ZvKGVnHB1ozb4ovu8g6L3AQTPyzbqE+CdcYKgNR2EwOCQUKUcjgGzw4j/6GZFeo+ZswC+2Eufk2atNdDNN93qorRTzjqt8bekFaD13C3igck7fge/ZD/bMulPHrIvp4qGQ4TL7jKy7VV028vvVygaXBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuG3AOemhQ5HFFSrRmmgNRHhv7580GQ8MY4YEGQHWzA=;
 b=ml0B0318t5KbTFUgdDT5usxqYELMRppB8eg7kgTKBQxXoeVLaHvCSOYTJR5G6aWmkRnV7rndLI8jiflugNUzfq2OC4/dP08yBZGftnCW9Mc+AxBLcDYvceV6c1kiI33td9Ymc1kskcnb5Nvaq0vOslhfX4+bEuRFRMbgJnJmP/tNf+7Fp0DNxa1FBStDmLmoUPjGklijpHtBy9HacIJCIaqQN2XPmTuoMg2gwmrEVuK6TZ0dTN4LmQXt1or5g5R1pE9oW3UrNh6aYk1lEyNXgNar5Wfx8uf6YEENSUTYR+DZ192z8IZxPwFPOkwoUppPOZLzQ/bDortDrlFIxjdiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuG3AOemhQ5HFFSrRmmgNRHhv7580GQ8MY4YEGQHWzA=;
 b=mLlv+HB9uAtpqLsLI0uo6ijQxw377a5zeV6dZp+nLA4MZD9EcSGmwvNMtGSh1TQ8/V7BSZO9HXGbJ10wijvd2lPG0O6DNSP5+7Q0lXTBxjmed1SZGBEAw4ohq+dXkexJJHIDpQP4l5HEmUtXmlsp4gr0O0RMSVoSF4Gsh0z7ESg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:50:37 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:50:37 +0000
Content-Type: multipart/alternative;
 boundary="------------4XPjFWjQHQ0d8IY6dqZmF82n"
Message-ID: <8c405b3d-7c4c-451c-a3d0-a15e88bf3d27@amd.com>
Date: Tue, 4 Feb 2025 10:50:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/44] drm/amdgpu/vcn4.0: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-4-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-4-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::20) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8605802d-9649-4768-81a4-08dd4533ab20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkN5ZXJ0QmVQM3V0SVV0ZHdyTXpQeHVRcTNZVjRjMm42YW4rNHlBbGRtakZi?=
 =?utf-8?B?RWFTekQvOEp1SDIvYjlxV3RzcVZpQS80Q2QvK1hsanpmaUZ3Z0FJQmNPemRr?=
 =?utf-8?B?ckRWRGRYMWx2VUNhSmZXRG5OcHlQOGRNMVpwR3dFSUtwdjZ4Z3VHVjJZU2Jy?=
 =?utf-8?B?MWZxeWJQbWwrdFpYaENzclNFN3FFVTR4N1lJL1Z6VEF2VUFibHg1dkltcGxy?=
 =?utf-8?B?RDNkU2lHeVRZVHRaRk9DcHlMR0dBaDNtekRBVlBRbmhTTStncjNUcTNUNG9i?=
 =?utf-8?B?WHhEN2xadEprS0Y5UjJ6MTA1bThQd3ZsQzBRQ0dVRjBEM3FiWStkTTYvK1lJ?=
 =?utf-8?B?RlllR0pieFJUdnB6TmE2dE9CWkNxdHd0NjhSWW1DWHNMSi9yQnlRM0xDeHRD?=
 =?utf-8?B?QnJPMGJvdUZldVV4YW9YWFFNVUcvUTc3ZDZ1YzZta3Q0anBkbmRDZWJXVFhD?=
 =?utf-8?B?SUVTcFYrYlN1cXhjWkpRaTJRYlJyVkNhYjFEQ1VMejRlTjZNelNyS1FLWGha?=
 =?utf-8?B?eTVnLzNOMFFRS0xhM2VjVkdmS1dJTndod0hSUnZRN3BLVWFKM0RjNTg4Kzg3?=
 =?utf-8?B?eGJVNm1MM2p2QkZVdktnOEdDUTBQWUFSdE8zajBRY1FvT1pGZnZtQmpEbEN4?=
 =?utf-8?B?VFEzYnpGRTk1bGdwVTBoNWp6ZDdndjZKb21XTk1tc0MrMHFFN25rYjIyelAy?=
 =?utf-8?B?T3dyWUtEYklDUjZUTGtXQzYwNTVTTDVFRUk2NmY2R3RVVG8yOE91ZFh6YWV0?=
 =?utf-8?B?bHZZTFordGlNdm1SZjVmUUhXSEdNaUI5Mk9yZkJLZjBiNE5Za1daaUFKL0xC?=
 =?utf-8?B?cGdiZFNNN2NhcmVMNmZPYXF5VmFUckt1MXJEeDZIK3dxSXFhWWk2ckxvUlBw?=
 =?utf-8?B?MHB4WmZ0d1JnT3N0YUw5ZkhhMDJtSGhmSzY5a0tuVkJobnBmU0V1TXd6b2ZH?=
 =?utf-8?B?b2dXRmxCRHI2Ymh3M21ENHVKQk91TXlSWC9nZ3JEQjhDOFM4M0hUNFRBM2RJ?=
 =?utf-8?B?dW8wM3hZellpcGRjb0dFT1d6akd4QUVsYk1XMU1ha096K1pHZkFhdDBGY292?=
 =?utf-8?B?akgxMlU2eXBRWmJnclc1Umh2TTVscnJySFRjRkVZdU9oOFNuK05IY2k5Y3p5?=
 =?utf-8?B?S3pKWERnVm5YRW1yak9YcFRFb1NiRU9vRXU5UDZsTTdMVjhPbTIvWEgwdDZG?=
 =?utf-8?B?S1Q0RHFsNkxtazZyRUlwUFZTMnFzckM3YWhjSUp1UnQ3TER1N3J5UE9CVGlN?=
 =?utf-8?B?MCt2c0VUWFZ4alF4alVMZFBodlZnSmsxekdHWU9RQnpDUlM0UFNpay9RMWR1?=
 =?utf-8?B?OWNvaTFlOTZmUEd3L0RRcDA4K2FDU2FwcXRqc1V0WWhIeW1jbUpVSnlWMnFG?=
 =?utf-8?B?RElwZUNPVk1BSndHcFFTdEVjVlY2U2lXRkJaZjZZQkdHOXl5U1EyOHdKVHhM?=
 =?utf-8?B?WDUxc1NSVU1mUTNsdzh5NWJzTVFPcnRFaWRCOHVIYjAzMGlXWlRQUWxXM2M3?=
 =?utf-8?B?VVZ3RXBiVGJMMUtYYlkyMmVqMHcyUlVqRHJzU0ZWK3VNWjRyYVJGQmxSbHht?=
 =?utf-8?B?N3JjWEZPQXNCMTcwNlBRb2lrc2VRUDRBN05ZK2RhN2hvUWZGeXpiNzJtUWlw?=
 =?utf-8?B?V0FtRVUwYk5iRjRUSXNRWmZwSlF5T1Q4a2xLZnRLU1p5OEdWbHh2Ny9uM0lv?=
 =?utf-8?B?MUtiajV6QzBMRyt2Q2xaMEF2U1Q0YUhYeEVOblVDYlh5c2pUZnFsL3ljNVFX?=
 =?utf-8?B?WUpLQXdMODVpWXlBZS9DcDZYdWdERThNaEVCYS9NMTRpNkVNZGVLa0JYUEdr?=
 =?utf-8?B?MVdwZy9iT2RPVlVjSktPdFF6a25aSU5JUVFrZndPajFnOTBmUHREeTd5UVYw?=
 =?utf-8?Q?aZs6grYS3zNlL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FDeGd4N0taUzlGRlZ0SHRlMXNSS1lqYUNGQ3E3WUNnSGhmQkhqNE1OQ0dx?=
 =?utf-8?B?cldRelJXeFhRK0tsODRRQlp4amw2Q3Z0SzcwVm1Xb0srbDV4dFpHRWxoU1lw?=
 =?utf-8?B?YU4valhraGVBNjVsMkxKZ1FjK2oycWFCM1RoZXpBQlpvbEtxck00TVlOZkZq?=
 =?utf-8?B?SDlsT1pKdTNrYWpkcnYvMm1zQmNzUnJTZk9iSXFzWlJGOS9QRlhGZm8wYUph?=
 =?utf-8?B?WkE4MkVlb2cwU2xqb2dtaDB6M2NyQjRJVy9qZnEyR1RZVlczeWl3eWY5ZnVj?=
 =?utf-8?B?aGxjVXJEZHViWGZ3aU1YVlJNU0k3KzhUQmY5VHl1V0xFRHplMThWNUZjUjBD?=
 =?utf-8?B?T0FsTE1nSjBZR2RZMW1BbnU4VUZobCtwbHNlODFZSmhsZVN3N0RLWnpaakxr?=
 =?utf-8?B?ZkdEYWd5UW1tK0svRXMxc2RrUXlMc2d5aTVmLzFPRnovSG9XektOaTVrdGtI?=
 =?utf-8?B?ZXV4aDk3M1ZvOFFodmpCT3k5UGwybExzK0dWOVREUEdzdWNHZkpEdXBZeFhN?=
 =?utf-8?B?NzNHMGtzYmFRUkNneDNBMnI2ZFd4Yk5UL0svOWFEQmE3SFVlbnlDN0Q1WDBi?=
 =?utf-8?B?Qit6cTNMQ2Q2WU9qSUUxZjJaS0JDdTlpa3M2NXlqYVd4QXNwblYvcldCWFo1?=
 =?utf-8?B?Ym5ZTS9ldXRsRnF4VUpRVXlpWnNJTDc4ZXNoeGdDVzRIeHNaN2lRT0VIdkxx?=
 =?utf-8?B?MjJVVGZLK0RFeUpScUEwWkM4clRrbHZaZEtPeGlhOTArSVkxM2pyL3pzVEZs?=
 =?utf-8?B?czBwOFh2S0NiT2xFNDk2TDQ3QzBiOEVLSnFiMkFwdThEbnNqVnNWajl2MWMw?=
 =?utf-8?B?UThZdUJoQVlKMS9XTGNWYys0TTN5emV0dUFkQnU1QjA4R1ZQWlZFaHFMbmd4?=
 =?utf-8?B?ZnY2U2VmamRDRGV2M2U4MVBzbU40Uy9GMTRoRHRlN2Q2cHUvMjlPdFJveUY0?=
 =?utf-8?B?dkNBTTBxaVBJVjUvTXpmcW4rNDQ1RFBieUNpTUlhYk5uV0plWEtaTEVPT0hl?=
 =?utf-8?B?NCs1dmY2Vk5TNENPOWxsNjJGdWF3ZDhYQmJxMWJ5VmlUbUJxUEIrdlpFK2c3?=
 =?utf-8?B?alhUNWpWN2dhZ29XMEJ4bERRR1UyQkhDY01CMlBIWHpDLy9laHJndFVjZ2Ur?=
 =?utf-8?B?K01MNXZQRjRvS01rckU5bFE4elhzYTdpeXhkeUR5V2g5dENDcVJzVURxOVJo?=
 =?utf-8?B?c0xZd2RNRXFzMGhibWxxVnhINEh1dkNRdzVOeVNsTjA0VlpidDJKQ2g3NUU2?=
 =?utf-8?B?MnF4ZWp5cXhLMmxzTTl5M0pUaFpUY3N4dENZbWtyVWlSOFFSQTRPclpHVWJv?=
 =?utf-8?B?SFFXc1E0TGRnRnBPSXJ6bnYzTm4ycm9ydW9EY3MvNGltaWVDcytQUStiSEVL?=
 =?utf-8?B?RVJ1MGZPYzB2cm5vM1NNREFZM0RaYUFMa0JLcmhEL1BXNXhvaDA5R1FLZVdK?=
 =?utf-8?B?RFkxM1c3UERjdWcrbXlkeWpmTjJhSFB4SWczVjhDMU9OODBONzRySDFtWmx0?=
 =?utf-8?B?K3A2WStSTVJDamNPbHdIaHhicTBRT0x2TUVJMHQ5MGgrTDdONWlLcWhYMncy?=
 =?utf-8?B?bmlPd2N0d2M1YVpRYnh0bmh6K2xxemdTaVZuQ2Q5TUZGTXIwdGVmYWhESWZj?=
 =?utf-8?B?bGxnOHA4ZFo5Mit3MEdqYzIyL1BLNlJuUCs5UEgzeDBRZVNuMk1qclprcWVV?=
 =?utf-8?B?a1FPcWs0V2RaKzFZMHBzRHh5QzFGZmg2SjF3RmQ2ekVaL00rWTl3UHN4T3RJ?=
 =?utf-8?B?YThSRS9TNWlVMXh5b204VEFHRWlWa1AvUEVkUUFKN3FnRUZWU0FnRWRidEpC?=
 =?utf-8?B?cXJYdHA2RG9rU1hvRTZyVGJqQXlZYUJTc2lHLzA2RWJCbGNGa3c2ODFlVnpP?=
 =?utf-8?B?R1ArWlpEVENCWlc4UGIxcldlNS9oWWx3QTI0ZEF6ZytXRFlYTHVBZkVMV1BX?=
 =?utf-8?B?aDVFOUhmTC9MZDZ0VlR6dkJqUWNkRGsyeU1kNzFLS3p4Z3QwTE5QY016WmJx?=
 =?utf-8?B?cUFoclpmZWtXZWoyOUt4aXFlRitBakhVRkRLV3NFSHNhazFjNml1L21SMTZk?=
 =?utf-8?B?bGhRcTlnR01QWVlrQTg2blU2QmVOTWgydkRTTDRFV0xSRVl2ZzZsL0dXZmhv?=
 =?utf-8?Q?lsUtHj0IoeURF8fsU+uIEI4fR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8605802d-9649-4768-81a4-08dd4533ab20
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:50:37.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxsQza4F7Z0Izt2ooDqvNO0mxUk13/3R1JkabJ9gUDmgvVtP+AWC/WidiGLf6+Kbo/vw7clFrnXIQbG6GVXgRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

--------------4XPjFWjQHQ0d8IY6dqZmF82n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:56, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 436 +++++++++++++-------------
>   1 file changed, 215 insertions(+), 221 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 00551d6f03701..c3eb4278bf465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1087,182 +1087,177 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>    * vcn_v4_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to start
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_start(struct amdgpu_device *adev)
> +static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		/* disable VCN power gating */
> -		vcn_v4_0_disable_static_power_gating(adev, i);
> -
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> -
> -		/*SW clock gating */
> -		vcn_v4_0_disable_clock_gating(adev, i);
> -
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> -				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -		/* setup regUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> -				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup regUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> -				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> -				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> -				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -		vcn_v4_0_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> -				adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> -				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> -
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(10);
> -				if (amdgpu_emu_mode == 1)
> -					msleep(1);
> -			}
> +	/* disable VCN power gating */
> +	vcn_v4_0_disable_static_power_gating(adev, i);
> +
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> +
> +	/*SW clock gating */
> +	vcn_v4_0_disable_clock_gating(adev, i);
> +
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>   
> -			if (amdgpu_emu_mode == 1) {
> -				r = -1;
> -				if (status & 2) {
> -					r = 0;
> -					break;
> -				}
> -			} else {
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +	/* setup regUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup regUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v4_0_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +			if (status & 2)
> +				break;
> +			mdelay(10);
> +			if (amdgpu_emu_mode == 1)
> +				msleep(1);
> +		}
> +
> +		if (amdgpu_emu_mode == 1) {
> +			r = -1;
> +			if (status & 2) {
>   				r = 0;
> -				if (status & 2)
> -					break;
> -
> -				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -							UVD_VCPU_CNTL__BLK_RST_MASK,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -				mdelay(10);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -				mdelay(10);
> -				r = -1;
> +				break;
>   			}
> +		} else {
> +			r = 0;
> +			if (status & 2)
> +				break;
> +
> +			dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				 UVD_VCPU_CNTL__BLK_RST_MASK,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +			mdelay(10);
> +			r = -1;
>   		}
> +	}
>   
> -		if (r) {
> -			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> -			return r;
> -		}
> +	if (r) {
> +		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +		return r;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> -				UVD_MASTINT_EN__VCPU_EN_MASK,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> -				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> -				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -				VCN_RB1_DB_CTRL__EN_MASK);
> -
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> -		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> -	}
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +		     VCN_RB1_DB_CTRL__EN_MASK);
> +
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +	ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>   
>   	return 0;
>   }
> @@ -1549,86 +1544,83 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to stop
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_stop(struct amdgpu_device *adev)
> +static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int i, r = 0;
> +	int r = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			vcn_v4_0_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		vcn_v4_0_stop_dpg_mode(adev, i);
> +		return 0;
> +	}
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* disable LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* disable LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> -				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -				~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -		/* apply soft reset */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +	/* apply soft reset */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
>   
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
> -		/* apply HW clock gating */
> -		vcn_v4_0_enable_clock_gating(adev, i);
> +	/* apply HW clock gating */
> +	vcn_v4_0_enable_clock_gating(adev, i);
>   
> -		/* enable VCN power gating */
> -		vcn_v4_0_enable_static_power_gating(adev, i);
> -	}
> +	/* enable VCN power gating */
> +	vcn_v4_0_enable_static_power_gating(adev, i);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -2051,7 +2043,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
> @@ -2065,10 +2057,12 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_stop(adev);
> -	else
> -		ret = vcn_v4_0_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v4_0_stop(adev, i);
> +		else
> +			ret |= vcn_v4_0_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------4XPjFWjQHQ0d8IY6dqZmF82n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:56, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-4-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-4-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 436 +++++++++++++-------------
 1 file changed, 215 insertions(+), 221 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 00551d6f03701..c3eb4278bf465 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1087,182 +1087,177 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
  * vcn_v4_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to start
  *
  * Start VCN block
  */
-static int vcn_v4_0_start(struct amdgpu_device *adev)
+static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v4_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		/* disable VCN power gating */
-		vcn_v4_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
-		tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-				((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-				 (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-				 (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-				((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-				 (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-				 (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-				((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
-				 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-				adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
-			}
+	/* disable VCN power gating */
+	vcn_v4_0_disable_static_power_gating(adev, i);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
+
+	/*SW clock gating */
+	vcn_v4_0_disable_clock_gating(adev, i);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status &amp; 2) {
-					r = 0;
-					break;
-				}
-			} else {
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
+	tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
+		     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
+			if (status &amp; 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status &amp; 2) {
 				r = 0;
-				if (status &amp; 2)
-					break;
-
-				dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-						~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-				mdelay(10);
-				r = -1;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status &amp; 2)
+				break;
+
+			dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-				~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-				ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
+		     ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
+	ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -1549,86 +1544,83 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to stop
  *
  * Stop VCN block
  */
-static int vcn_v4_0_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v4_0_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v4_0_enable_clock_gating(adev, i);
 
-		/* enable VCN power gating */
-		vcn_v4_0_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v4_0_enable_static_power_gating(adev, i);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -2051,7 +2043,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -2065,10 +2057,12 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_stop(adev);
-	else
-		ret = vcn_v4_0_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v4_0_stop(adev, i);
+		else
+			ret |= vcn_v4_0_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------4XPjFWjQHQ0d8IY6dqZmF82n--
