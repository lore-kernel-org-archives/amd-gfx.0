Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF3606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=29l39s+W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A91311297F;
	Fri, 23 Oct 2026 06:46:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2141011297F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 06:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5EMVElnEnpfIAbNwkSrQ6dys8xzXLkxARnmymbCpsXg8O4l3JnkjlJPu0sL0ZppvvrvdZHPUf5KaxBPupF3cYhJPEaoMJqpasBgtcapWRxRpAh8E481jpBvhvLhCESiETp4B9Elx1Da0x6Yl6wBZ+OCsP9JmGohL+rSr9UM12oNMllK5t4FMpviUEVsXYI0OpkA8ipSHkjvrj2z/w5PkHIM3SV3yW8ndPOVUbor3c3SKbXQSrhqJ9ejuvCc9j4PMQIQAXLkQ3YKNaRtx7hGrCrlTKsn0Xe5Fczf4HwgXbz0awU/5PO8YGVmPCxsx9JO3fBzgMiFSQ+3HQQhj0m09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2Wq5Yp69b5wLsbgKDPIVgyycTYdkpMBFeeYdeD3r7k=;
 b=jhDRuaTb/3SswjuTtC7/INNcpOk4Oy9G5z7sUMH0C5n3WsWjuUwr68ACxDcHZrMvzU+LwO0bzcAp4HPnWXlhWk0MXANZoiEEcNMGa8peuioDLpluBJkg0EpGvZz46vAX4CcuYhs2n0l0qYJUYC12ynIMzMFugpp0QPiRSsWEYjuyhzQHtKn8q5UrSItVw1y9qh5jd3xDL4gnhc596xyepLuvdJ5Xp2gTyXIPUkCvV8BftaxXQwNoQrO1aXye0POgoISZUwmzfD1G2nVXH/4Lz3dpkrnWJgdfi0g3bwYkTLKQEgD2Hw1Ykey7R27UKsfGQ6Xo+Oif02g/saPjb1zRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2Wq5Yp69b5wLsbgKDPIVgyycTYdkpMBFeeYdeD3r7k=;
 b=29l39s+WTesjPTCT7W1sQxHVqXK10C8xQLDK6v8Kg1kXFpBFLhqicqyaCPOkl1NzwFBX15IEeGUF00HyBDJxPaoa1YtZK5gTHiW/ifYZ2ZOyuQujslTAoIwtdubA8VlPw5U7/M7vm1VdgRZupIqLt2+Qx2uoEfgcZZ7J8AhhI90=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:46:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 06:46:28 +0000
Message-ID: <1999ba2e-6a9d-467a-8f2c-d5eb16a4453c@amd.com>
Date: Fri, 23 Oct 2026 12:16:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
 <20261022083331.3019779-6-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261022083331.3019779-6-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff4e8ee-53c7-4e39-5624-08df30d15d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261022105027099003|261022075727099003|56012099006|261009223327099003|260925022911599003|261009220027099003|260925021311599003|260925021911599003|4143699003|11063799006|5023799004|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: b4B4BsZmyba2R9llASDFDQXab1M2eBiqOKtvKrUIXaxVKiV6jyOJUDygBHiUH7m2XK4+HsJyJXf0dv/TR9L5TjrCdiBwA3p0oRbu3mWVAqy3xqdhktR8F5JTt0ocnnnYDeV54C/QbrSbJFFl4chl9m0lR2FOACbFDKe047iRWbuXMI4wexdUsi7PM5fpIfTxUhEvH+/GhyeayXYpN2vJerx/cG6IxX6HAQP6o/Y3sNdy2TxivCR1h50y5hCRUJms37+nOUrroYQCoBp9Ew9LeT+hvKNk20N/zytvD6lddyJ/hQ5Pofnd101a8wWpglaYT5qGXQ1SXfDJCPPXku3zqzUvF8ajpWj5EL8h38U8+oW5NerwI/1PsTrZ7Esq6ljCUV92FwlPTbgbtfrpTLcj98/FnnWeXXL5JpDrWWZyqvFraFMbFLpLbV04QXtdMJHzqX1F1/+qsRFMrVRNKwHqECVsjJfFjgQZp9pL2hbCHUTTjHhJeVUwx7ZVjJc8rRxqEVwfhBVQHAGsRNJAX8V0/HkzxW/NYG6x7bxxhJKG8lAeay3rEDYAXTiNmb1/zmK9bSwR18mdjWvWEQ28m4Y0sZI3dFFKab/gs/2bW+LMHH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(261009223327099003)(260925022911599003)(261009220027099003)(260925021311599003)(260925021911599003)(4143699003)(11063799006)(5023799004)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261021121427099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRKb2pqT3owdUlSMDh5d2J1R2l5dEJKejZXMWJtMEFqRHlieWk4UERaZDE3?=
 =?utf-8?B?bHgvYnVaZzc4QnM2OTZicXd1eFBTTmZlc3dQSEVrSzYrK2N0dWJKNCtUNUdU?=
 =?utf-8?B?cUNCeldZb09XaTFQckM4OWc4dEZCTSszY2h4SjdVeTNCTENlYlp5bm13Nkly?=
 =?utf-8?B?Z3kzTVRqaWM0SHpqc21XcHhEUmtJVjFJdXk2R0FRTWdNTmZIdjZVMGtscklp?=
 =?utf-8?B?UWVPbDFXRmE2czRoZmlEV2orODVkUXVQbWR6bm1SWlpxblRQa0pPY3kxdkJW?=
 =?utf-8?B?cWVqRjFmTUxkd2JPdC9DWW5RVHBPemx0RXU4dlhTSGNFOUlXZk1iUE5yUVpS?=
 =?utf-8?B?NWVROUpWSithVXRvTzBiR1pERmRYVHVtaXJ0TEpHdjF4WmlRQXFvaXhWcHp4?=
 =?utf-8?B?WEtHM1BhcWpaZ1RUOG9iQkl4S2VWOEk4TG54Njg3Y2NaZHVDakF4blhFSlhy?=
 =?utf-8?B?bklMSVBZcmlGRlZEQk93QUl2NUsvRmcveFhEWVFsTmNSRTcxQy9Bd2R0U2Fr?=
 =?utf-8?B?dG1UL05LM3dDNWZGUDlTTWplMmVLbzgvZjkvclRwbFBRNi80ZWlTRVI3OUJa?=
 =?utf-8?B?dzlYTUNFUlppWFd1NXN5WUdnSk1ZR1MrY3FLUWo2UldUMHUwcHE1eEY4WnNR?=
 =?utf-8?B?cFdjWmFmN0hwMjBOdE1yQjhrcmlHUS9GTSs4UGU2NWVlU0JWdk5jaXFMbHhj?=
 =?utf-8?B?enM5enJMNFpoWnNsamlTK0R5OFZvRzZPRWdJdEZyRmU3VVJQY2xmbXgyYmU2?=
 =?utf-8?B?Rld4MWpKMHppMy8xdjVScVlFZmNmblp3dUQwb05nR1NaaWd6VktlK0JuWm0v?=
 =?utf-8?B?bmI0c2dZdlZtWjkxb1JNU21RN2JuS1JhQlBzb3JkRnlRdysrMnlRVGw1T0Ru?=
 =?utf-8?B?OVR5SUtYQjBLajNNaDVwbHVpU2dGWGZqeUVpeU9Ha0plTzVzUmplWkZHMy9W?=
 =?utf-8?B?RS81ZFljbjljWmt2MS9ublpmL2tFbVljZFRaWCtPY01zTHZKbXh5MFNOZXEy?=
 =?utf-8?B?Qmh0UmlYMmhBblQyY3NIYzdqUzRaRFViMDlxenE2bExCRzZYbkkyQkF6cmxV?=
 =?utf-8?B?NUNzaUJEQXcvaVdQRGVLQU1JOXptNzZPdzNwdEwwUnpiZHQzTU4zNkJVaHg4?=
 =?utf-8?B?RFpJcFFRQzlsRkN6alJpQUUrVDc2VDJnYTFqQmVacTdHK0NXSExrL0s2SEo2?=
 =?utf-8?B?RG9xbCtWK1lSVVRDaS96VDdOTFM1SVNtSmxaSU9FbjZ0YWlPOUdETk8wMFk5?=
 =?utf-8?B?NytZRGhxVFdITGlISU1TZmFGRGZoaVpsTTFxWDZPVDA3WC9QOStWVjBCdkJ3?=
 =?utf-8?B?WUJycFVBSWlidXZGZXRnU2FBQndIZ1JrN04zaG1OSWU0WWUvd2Z5aU1sWS8v?=
 =?utf-8?B?ZkdML1R4UklqRURPbWZDUXdOeTRoWGc0cVFnd0RLSVVUeWd4elpESFRwWG9C?=
 =?utf-8?B?WjY5VTZOdTBEeTBjTU9aSVZ0RzZiUEdXaDhzSFRSVXZYTTdHTStvaDRWUXBh?=
 =?utf-8?B?RWxpV1pVekMwNTRLeDRtKzFoU2RKdmd0TGFWSEg0NGpLR1pIZzFvMmhqZ0Fj?=
 =?utf-8?B?RnY1YjFpTmt4Z1dPcHhFaGtyVnMrNlc2UzRHaDhtVjVMRjZ3NkVXclJJNGta?=
 =?utf-8?B?WGtxdDlrTGI3bEJmVGNMMjVHS284cGIxQ2RvYzZvelE2cmIwbThoYWlmY3JL?=
 =?utf-8?B?SXF6ei91anhtU3NxcWFHbGlzenNDK1NEMUdwSExkdWJuYlp2cDdXSXRUZUNE?=
 =?utf-8?B?aUFhMUJqM1R6ek14YXdjM2VmbWEyYkNuWFovVlpnUG5vWDNBSUk0dGIyZlZw?=
 =?utf-8?B?eWpveHhRTDJRMkIxVXBaRDBVSGZybzBna1JRalhwMXB4RlBKenkvbGlUTkZn?=
 =?utf-8?B?TzVGK1A5VEMxaGxYS2JsSlcwUTBCaVlmYlJnUEpmQjd6TVJhZlAxRlRPZWtk?=
 =?utf-8?B?dXFiZloybUk1TTVWeFhENG1kTmJsK1hSREJNamhkenFWdlVReEJVUHIxdmYy?=
 =?utf-8?B?a0VPTU9MNzFBTVU4NU8ra09IUk96TENtUk1XckJ6QkM2QVVXWm4xbTM4SDhH?=
 =?utf-8?B?dzkrZ2tGN3hsdFBHYjBQSUF0MnF1djNBWlIwSHdrS2V1U2NtdnBiNWpMY0cw?=
 =?utf-8?B?K2FsemNIZGJrZjdDQnVqT21tT3o4Q08vekFkU0hJaCtuSnM4c2lqdzRsSU9r?=
 =?utf-8?B?UjZiaWZwQkhLNVo2MTVhTUhCeml4MENWYytDbXZCNkw3bS9CK0lCbjJBM25K?=
 =?utf-8?B?aGJjcWVvYjdYVitOMXQrNXV3RU4xT1lnOXFQNE5od1B3R1R3dytpM1E5L0JE?=
 =?utf-8?Q?nE8O7KYq1zrcqT63oQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff4e8ee-53c7-4e39-5624-08df30d15d3b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:46:28.1662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNBy+ifSg1tYoL6yBF3dKYXRn/GxYqZKGlirWMqVCJ1LDY1cWgNoMtrfRAIX0OJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 22-Oct-26 2:03 PM, Prike Liang wrote:
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not
> wait for them either, since everything the workers depend on then
> becomes a dependency of GPU recovery.
> 
> Make the workers take reset_domain->sem for read, so they wait for a
> running reset instead of touching the hardware. hw_fini/suspend run from
> GPU recovery as well as from system suspend and unload, so only skip
> waiting for the idle work when the reset itself calls them. The reset
> holds the semaphore for write and would otherwise deadlock on a worker
> blocked on it. Outside a reset the cancel stays synchronous, so no
> worker touches a block that has been shut down.
> 
> begin_use also runs in recovery for the IB tests, so it never waits. The
> worker now checks the submission count and gates the block under the
> power gating lock, so it can't gate the block behind a concurrent
> begin_use. sw_fini still cancels synchronously, it never runs with the
> reset semaphore held.
> 
> Update versions: https://lore.kernel.org/amd-gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> PH7PR12MB6000.namprd12.prod.outlook.com/
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 32 +++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 35 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
>   23 files changed, 76 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 87f879a2e4f4..3c1e7bf31a08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   {
>   	int i, j;
>   
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1U << i))
>   			continue;
> @@ -97,7 +99,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   
>   int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
>   {
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	/* The reset mustn't wait for the idle work, which waits for the reset */
> +	if (amdgpu_in_reset(adev))
> +		cancel_delayed_work(&adev->jpeg.idle_work);
> +	else
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
>   
>   	return 0;
>   }
> @@ -114,6 +120,14 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   	unsigned int fences = 0;
>   	unsigned int i, j;
>   
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	/* Check submissions before fences so a concurrent end_use isn't missed */
> +	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
> +		goto reschedule;
> +
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1U << i))
>   			continue;
> @@ -122,13 +136,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
>   	}
>   
> -	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
> -		mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	if (!fences) {
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>   						       AMD_PG_STATE_GATE);
> -		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> -	} else
> -		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +		goto unlock;
> +	}
> +
> +reschedule:
> +	schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +unlock:
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> @@ -136,7 +154,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   
>   	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +		cancel_delayed_work(&adev->jpeg.idle_work);
>   
>   	mutex_lock(&adev->jpeg.jpeg_pg_lock);
>   	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..fee6bea52e5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> +	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   	amdgpu_bo_free_kernel(
>   		&adev->vcn.inst[i].dpg_sram_bo,
>   		&adev->vcn.inst[i].dpg_sram_gpu_addr,
> @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
>   	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   }
>   
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> +{
> +	/* The reset mustn't wait for the idle work, which waits for the reset */
> +	if (amdgpu_in_reset(vcn_inst->adev))
> +		cancel_delayed_work(&vcn_inst->idle_work);
> +	else
> +		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_vcn_inst *vcn_inst =
> @@ -470,6 +481,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	/* Check submissions before fences so a concurrent end_use isn't missed */
> +	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
> +		goto reschedule;
> +
>   	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>   		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>   
> @@ -490,15 +509,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>   	fences += fence[i];
>   
> -	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		mutex_lock(&vcn_inst->vcn_pg_lock);
> +	if (!fences) {
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
>   		amdgpu_vcn_put_profile(adev);
> -
> -	} else {
> -		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> +		goto unlock;
>   	}
> +
> +reschedule:
> +	schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> +unlock:
> +	mutex_unlock(&vcn_inst->vcn_pg_lock);
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> @@ -507,7 +528,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>   
>   	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +		cancel_delayed_work(&vcn_inst->idle_work);

I think calling amdgpu_vcn_cancel_idle_work is sufficient here. Other 
changes to idle worker other than down_read are not required.

Thanks,
Lijo

>   
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..a6438950854e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
>   int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>   
>   bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>   				enum vcn_ring_type type, uint32_t vcn_instance);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..b048fd4b8b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..f6a9258ae3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..922711aa06a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..fe7ab9cb35bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..f4896ad9d1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..87efc3c2b9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..91968ad26f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..27116d1e9e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..7e068c2d4d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..16daeb61114c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..470d8f110799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	/* Override the work func */
> -	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	/* Own lockdep class, this work is still cancelled synchronously */
> +	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
>   
>   	amdgpu_vcn_setup_ucode(adev, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..ba451f2a2534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   
> -	cancel_delayed_work_sync(&vinst->idle_work);
> +	amdgpu_vcn_cancel_idle_work(vinst);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   	    (vinst->cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..9dd4c313cbe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		/* Override the work func */
> -		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
> +		/* Own lockdep class, this work is still cancelled synchronously */
> +		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
>   
>   		amdgpu_vcn_setup_ucode(adev, j);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..3e85abd1e82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..5b47a643d725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..5aa09c3bd79b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..9693950cd16d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..0c189063a6ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..3fa553fb41d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..eb13f792e25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   	}

