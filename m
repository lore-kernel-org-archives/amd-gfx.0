Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418460A261B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HHumYt/o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1543E10EDED;
	Mon, 23 Nov 2026 13:41:24 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32BE10EDED
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 13:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ4yR4VpgvhwwUnXeWfXgEMhTdNI3feoNSVqzmGlo6R8PruLANWwnh8KiqiCmlVVOolCOIvgkBJM8jiwCq2Np4qtmNoxKqWBFBXseva5sK4gmMLCRL8ysC8uvpwrKfQJwaKv6SqX49WReFd3VFFmqhB0yOoU3CHQudilmooz2MGBVTd0rIz5tamJQrelFukrsoZ8vyUqJKGGaKQfsMu0jtN0EX7U//NARl5E3pbPkD0kgY0kBH4HcJQwGbO2V6itkKnP2XuLPZs2UzGVzIcQleWsRa8f/ttDslBCk3qqJcVzShocCkW234z9UlwC6D0Jx8N4XC/iUVIDlSYukDQAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xE1T8egcPq41S79ztIOMokCUXSh0Z0gBUuYTmCe9C4=;
 b=XsS0z5jsE+ScppinkjnwUYDKC/0Mudlbe0Ep1CGd7hs0SZ0487c4tbaDtyK/bvCVZ1j1uEKR2GyRjnkS0J864ZFgndhxmHKEW5vjuBPE6Ecpc7dATJu7BI8YnHzDr0V3ZmvgrHq9en7NfMRCazXVqZRkwFCepZQEwyftbrBit+tw7nFHN1CtGVPB0Lw64T/BPCt5qGrSCWPtrg0hwt8BBmSSApXdvMLcv8l20ytxCv8FuVV1Y7u8w4iAOJoi8512hZEhJMcCZrr/RRu0nY/Ziobwezgf7CtSb5HVRq616gHPj7JFmMgWEcVGCVmDzuk2h1ZHpUcYFTVv1Y7BKGfkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xE1T8egcPq41S79ztIOMokCUXSh0Z0gBUuYTmCe9C4=;
 b=HHumYt/oC3jrQdfjscQdNgktMeYyCe1csbVQX9WTPF/a83fsF0u7QXqqw+UBZ/BvKcNE9DBQ9MAJaZDrCJjfPiLZsU4UTZMcWHp4ksQ91EAzsCPAaqnNxrudwsbbHo2HRbUkeFwRLuVpG2DyOwgn+5CYig8TsKGN7mvYkqpfEhY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999181.namprd12.prod.outlook.com (2603:10b6:303:2be::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:41:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:41:13 +0000
Message-ID: <3b7ff1c0-94a7-4377-a04a-bc7c56e50ebb@amd.com>
Date: Mon, 23 Nov 2026 14:41:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 "Mu, Zihao" <Zihao.Mu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB4572DA4F9D571938FB7C4A999E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
 <awQUEmwUoWSSDDOV@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <awQUEmwUoWSSDDOV@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999181:EE_
X-MS-Office365-Filtering-Correlation-Id: d235fa73-79a6-4315-f3b6-08df49677081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|261026121527099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1o+fog/nQysfrKxqobT7hOppLPknARSalkQOI02g/6Mx0mBy4xce6pQxTqHAKCA2ADTQLQ1+bLYt4/rNiMMsyo2I2/E6yTeQYqq1g3JASQLxrhGV3BEHfUhu/2ls6rc3lj0hWNd17I783tOPINYIKsXVzDvfelCa9kS86y0ZIOciATkJL8NvpdzdUwyiCWrHyJf+rhPPRx3YyRyf9t2C+z/sDDP5D1cGEvJM95A995XAaNJKZPsgrjD28p8SmvjnWTdR/wxTR4ZLgfsk3tp/ZqGsJ7tmlnaQQHbKzfmBSYRBp6qSvs7bvpyD9u+zMTn9rclxRnjy/bzuTRA//zd3TslgUP/dadRAbCdR0pKqzsyHfxvOs5ZTNE1BDd/M21g7PZNBswKR1vFinQy9n7E+VoBzFrxMThGRr2jmMvNfjDk/Q/uliHfSRYcpDOiIn3Bj8qLx2jXOJ+L4N9FQbVQjttDH1SN9FCAWq5tNFUHkVRA18mhzcj2HxXP4Rf2q5w6YX2UBnTEPluPD+XFDLA96S7JWI72D5UN/OChib9WXQCvCfi402gSGIVzwff4FEbn/Qbx/vhjN7wR5VMfE4KJt1LWXPsYOrA/Yy3gkv55q9cdkRVHCZrpBvmsQhVV46xdZWXhVgoDcEgEauzdo20o/vgwgBWwM+BhV/Gt8adGO3Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(261026121527099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDEyTmlEUE5GMEt5SlRNb3F5Uy9zT1RoQ3d1OC9tZXc3eDhGamNxQUJXTzRQ?=
 =?utf-8?B?L0o5aGpyTFYxVm91YUJ5eGc5b1NsQ0h4TVNKVzdwblhEZ1h2ZmthaDZNYjJp?=
 =?utf-8?B?eTR1bU1HRW40Rml4d09XSGlpNGVuU3FvVzBzZWdPYmhvUWNYSkdNWXRWVnhX?=
 =?utf-8?B?OW8vSUVBS0ZYRTVOUlR2SlhzaTR6TUlpSEhzQW8ySkdIang2cTF0ckJDaEIy?=
 =?utf-8?B?Z2pDT2t1WnRUU3RRK1dnVUR3dzNsNnBLcklVREhVbGRHbkxtRmI4ZVdkaUdZ?=
 =?utf-8?B?bGxTZTJjLzBDNWRKUTVRZHQ2YVRKWXprekNOSGFSZWtRVWpEcDJUdiszc29a?=
 =?utf-8?B?ZDlacWRmNGQrQU9UM0FIQTdPc3dRNC9wcGZrMHRZMzUxb0FsaDdrdnFaOWRR?=
 =?utf-8?B?em9rOVR3QXpxVFVWN1J0L2NSa253dWFJNktTOW8rQlFCSWMxY2JNZG5FVTJP?=
 =?utf-8?B?dnN6cFVLMlZSR0d1NVR0elU2dXI0RHpEd2ZHZ2dQMXZDSi9DVHQwNjNyeHhr?=
 =?utf-8?B?YkVaWnlHWnJjcGh1R3M4dTA2RGZ4WjllUGZ4eGZudjlGWXJ1RklNYTFTVzFW?=
 =?utf-8?B?YVV4NUNtOG1hL3k3MHkvbDVBWkpWVWZpU2tQL1ovcElCbWY5NFczVXRPVFR5?=
 =?utf-8?B?ekFReVU2TE9QVTQvaFJwNHIrc3RYdlR6ZG8wZHBEMVM1b3M5WWpFL3U4azhU?=
 =?utf-8?B?QnYxM1YwWURXWmVyVS8wbEJ6U1EzU29wWEZVOVBkVTRoZGRYZTRqZXhqL1BS?=
 =?utf-8?B?eHptZmtqTTlqSG9sVDVlclYvR3UxSzVwd1ZPSDhORVp6YTB3blF6RlFmMUpI?=
 =?utf-8?B?cTBKbGV6UFVSa2QxWjdPOEQ3cmlPbWV2YU5MUXJEVXIrRnlPSkg1SGpBNDFN?=
 =?utf-8?B?clVqU3ZYMVo0bVFiUk9haDFySFdWWXV1U3M5TFBhUEJ5UkNDSFJ2dTFXMXRm?=
 =?utf-8?B?dDdOaEI3WlVXdjgwYUl6dkMyc2VLTVFFZkF5cVVXbWsvMENDVzRWaDE0TVI0?=
 =?utf-8?B?Y2xObmhENXA0MHRWRFVqNncrYWJFMXR5OG9oWHRBeW8ydElJWXRHOUNQQXRt?=
 =?utf-8?B?SjgvektTM1RiblBXNS9KcVhzVWtSTVJNZG94S1dIelJQM2ZVaTl6UnFRbUc4?=
 =?utf-8?B?SWJsOFFBTnYycGxNMjJwbmg2dkN5bFdsTEhrZzcrbXhqZVgxY09lRFZPTkM3?=
 =?utf-8?B?TnhHdDhDUTFQeHpyK0U3d0h4M2JteEMwZCtEU3lkblI4dUZOaEljUDhqQit4?=
 =?utf-8?B?MWNUSytyRmhqMXpVNlhmZlpVNVQvNDlyY3BMWWhGZmJYaEx4SWVXK2o4M3Bl?=
 =?utf-8?B?SDc0d1NYSVhSWmxzbTZ6L0gvc1FaMktyNTVjWVpna1A0eGpDQnp5T2J5QzUx?=
 =?utf-8?B?VE81WWpMRUhMVEUzM3hSSSthVUdYL1hDalBtaGI5ZFJ0YjQ0KzhSOEcrdkxK?=
 =?utf-8?B?WDl4Y1FoaS9odzhKTGlQZGpXc252NnBYYU5hZVBlTnIxZG82YWVrNmVTM29Y?=
 =?utf-8?B?ejFpd1l0NXJsbUJOWHVKVk1IY1RvZnZvMGJubWFORitzWWNDSk85QzB4Mkl6?=
 =?utf-8?B?NzRUZTYrZ2VxamRPZE5rMjQvdU9WUGsvWFB1R1JET29WaC9QZ3BJbDI1K3Fy?=
 =?utf-8?B?dGFxUTdUOFkvNG04Rlp1b25jUWMrRGZvZncvWDF1VUVnNkRSOFgyVm9pRlVx?=
 =?utf-8?B?c3dYaVEwWHUzdTM0c295K1BaaC9SamgrWXdFRTBFZVhmVlNhT0xKOGl0LzBz?=
 =?utf-8?B?eWFKQmYyYSt5azRhQlh0QWg4UUxZTDh2dHJGOWZNbEdUQWlVSXRHZ01MaU1T?=
 =?utf-8?B?SmJkYWNTbXVWc21ObEZ1eGdGY3VKaWpIUzNSYTFobCtjcmJlVWVyVzNjTWd6?=
 =?utf-8?B?Snkra1hWRk5TaHZTZFRPQ0pwcWFyYkRDekEwVVFycDgveC9rL01BVkN1TDZP?=
 =?utf-8?B?K2F0R2c2QnNPQUxkSGJEQ0UzeXIxQ3VjUXJIUU1zeHFwdHhYZUlYbkJZN0tK?=
 =?utf-8?B?OGhMY1QweDJnc2YzZVBnT1dvSkdnaStPRExQN3ZjdUNONldFWXlOZDl3akNL?=
 =?utf-8?B?eFRNQjQ4MFY2bGlMK3ZHNGVEVFByWTlsakM0RmZLcTFSak9sOXZvcWpBVnl1?=
 =?utf-8?B?VGFkekVsQTdqL2RLK2RqSDk3d1F4MXBVUWJTZVlKczltVjB6TE04N0VNM2Zu?=
 =?utf-8?B?eTY2dUtYTjI2Nll3OStUTjJBVFpFNDc2SzE5cTdrOFlySy9pSisvdTgrRTJL?=
 =?utf-8?B?Njl0WkF1a1dJclkzRFVma1hSaHk4K0MyZlg4VEc5VWhQYnZDbUx4dktpL3RJ?=
 =?utf-8?Q?pJhjVguokDxMC8gbG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d235fa73-79a6-4315-f3b6-08df49677081
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:41:13.2665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb+PmoT1Vf+ZmrsizKW18daq6ka++gYnl5Fb//u6LzhPwzIPPWFfKz7kgkbOTqke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999181
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 11:23, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Nov 17, 2026 at 11:39:43AM +0000, Mu, Zihao wrote:
>> Hello Christian, Alex and Cascardo,
>>
> 
> I had a hard time trying to apply these changes as they have pre-requisites
> that are still not in tree, and b4 has trouble applying it as the series
> were submitted as a response to a different thread.
> 
> May I ask that when you submit a new version you do it as a new thread,
> please?
> 
> I wonder if we should just submit the cleanup fixes (the ones changing
> return type and parameters in the hooks) as a separate series and get them
> applied in the tree already.
> 
> Christian, any thoughts?

I agree, generally we should have bug fixes first, the cleanups and then tackle the larger rework.

Christian.

> 
> Cascardo.

