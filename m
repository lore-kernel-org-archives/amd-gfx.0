Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE7C52D7B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B01810E059;
	Thu,  8 Aug 2024 07:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="srpPybIw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E06A10E059
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 07:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErV4WJgP7wek8P7GLAgNdTBb+4utb1J80hhs7W+rcHMkFATVgffbN01r0hLnIttvL8LcVLCOt/bhUOGhwhI9w4dk1xOufOt/4WjF68xCBvFesR4kip2msBf8566zOVgNMia/VifVDjEIPUge1aXbAuqsnir+IYBURRaBtAOMC6qE4gXzjFqqMIUROl7KvhCOtnRlwJPLLxZNnuRMpnRjYsx/iyrZwDo7BWfBBNUDDyYfOhS3v3yGHbEORzRzBov3fzhpUYWOmqQX+5Bn4keGLYrrtIGzXLJcptz9RSXQOJimwKG8d0eaMdRcxboH7KOcxJnQqN8ry6LDLti32BG4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMueHidWJlPpZvE0FJmE8grjJxZo8Zg+HsaKTxyaW0s=;
 b=Noy824R29HNvJT4SAXG2zMNg+eC1jLGXe/3z3Taqa6A3FvH4L50pM5cwC7Fn6NIKcLgIyb6mPOMDlz6Ev3kCbKm9nvTowTNyCA1IGQ2y3OgY/eWFkKgkwYVa5MpdEPw+E3vlQkHvFTCiFSo2d46KleCrOsB/x/1gJ6yG4g+1iFytShL3QAKAR3q0Tx8Ys6tkSNOQfRGDJ5P3JdugvaOczKjBAVYtDHM4BAdsoJBxtYlAPESAiIt9q3fhv11FPjFqlBnG8fs1LeUtvTbLNi0X6u2/Mb17BcocNfwDwKere5yxlwlB4Syi73L+p60wsw58DZrM/pldOyy3Q/eW7uWqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMueHidWJlPpZvE0FJmE8grjJxZo8Zg+HsaKTxyaW0s=;
 b=srpPybIw5OHLLYXt9YZ2/PKCxBFw/OaEMUs4QL86PQI+grRwCVbGu0kEfWP/3Ai6dno0PhROYAi+W4cChTi8bAMLs7UDY5VptmRKNjjnAqihfWfs5E/TfE+9OFwKplyuTGz9xAAYiiAZPWrK3xJBfCdgSBq6So71MAr0sSckaW4=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 07:46:25 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%4]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 07:46:25 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
CC: "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Index: AQHa6KT3/ppEMp7adUygdPkvET7CTLIc+8iI
Date: Thu, 8 Aug 2024 07:46:25 +0000
Message-ID: <DM4PR12MB5937E92CE07B55E73C10D09EE5B92@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20240807083624.1729349-1-guoqing.zhang@amd.com>
In-Reply-To: <20240807083624.1729349-1-guoqing.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com,Jonathan.Kim@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T07:42:35.2860351Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|SN7PR12MB8102:EE_
x-ms-office365-filtering-correlation-id: 24ec5b52-81c8-4854-5c74-08dcb77e34a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1RIdgdpiIs+QSg70XQKeaS6n/p50YArIdgNSpbwb1M4ZkhuHFYVZvozQizuF?=
 =?us-ascii?Q?tpX77eBq1t6CeU7XPU87T8GzdHtscvZ9XCceIDcQBx/bqrNN38z1KRgHulDN?=
 =?us-ascii?Q?CcD1CSc3mrWi4y9u2FEo25BrYy3k3+9STRHv1sunDntvwGk4mxHPU3fTaQTO?=
 =?us-ascii?Q?wpNRCznijOvVY1oVr3sEUKhGYjsv7qRdCqHAnMGBir7AoEclp3SQC51refFJ?=
 =?us-ascii?Q?CFVQL7/hjDCYZZycKDVlcqIrrSZCDBnlEuI3cGOmTpr8ECfB0GkBUhuSiuQT?=
 =?us-ascii?Q?IctBB0PHg4yDx21MPe8PM6taUVKlHXZSgzJ1agDx/dW1gnN1xbalE/tPYjhG?=
 =?us-ascii?Q?ZgGmnXvrA/bZiOG2EFy6//r3cws9I46lOm5lVUoMFJY90mPQdRm4s4SdCeiz?=
 =?us-ascii?Q?ZUjpY6DNfHSsgzONzDrxLWowJvjCPUPCnSTgdU86yE0VGFXMxOSdJ8/7L1LJ?=
 =?us-ascii?Q?qaXQ4BvYBm7GoRhCVI2Ab4VuymPtkOdDgyO9CIJh6F3ys00NLcIq81Lo81rP?=
 =?us-ascii?Q?5fP/2KOUaGeRuYKq4XGm1H02a8s72jaRLQXt/fpT+Nh21/lJ1FuGKJmXfK3a?=
 =?us-ascii?Q?GkmdS5wOOp6zee15AVmaAWYPfSQq/BnUP5edcB2dnCxsfBEzrPl3gviaSvgk?=
 =?us-ascii?Q?CX/E3TVg2YhQvgJmxvraQZJwJTPGN40CBnFuarby5igP5G7fzrt6dl1/klUk?=
 =?us-ascii?Q?/McKhSXU/hgtYOb+z8rdufEak8u6W8uPqostRRXMcCI0jVsWErxZT3ENCZ1/?=
 =?us-ascii?Q?sbdlKfnw64aAHewGPxql/kh/mlxPIUvsgnx6lBUuD+C2pE4ibmgWvhwIA6Ej?=
 =?us-ascii?Q?x8fvi0NAx5IyGtBihFOcrcLrcuDoYVWkZ6aDKnVhS7cDLHiGYzcm+dediXpn?=
 =?us-ascii?Q?24KuzRdX09MuMDQt50+2p2n/zeyvHYQ6bx/UkNC5qRXj3Xpi9B2sbJ21q2mg?=
 =?us-ascii?Q?j9MjOY7IfC0cvt7ywq07N+zmaBWH97UMLVVwPLK4s1W5cLey18AtOG/B+eZE?=
 =?us-ascii?Q?xSqzbtAeOL1e5v2+uSE/TjD/4+MqasHr0D/jfYTbrpsaOxpCfPzZLmF2RlW4?=
 =?us-ascii?Q?d7p2kY28Y8iM8LRIzEnXDoKyrRbQ+XS44RhCBab+p4JY7K5509S/7hvlPyH9?=
 =?us-ascii?Q?tB4CHvm7f1RDblrFBNhZYdzBXxw4HcsvUwjlH+vfX34sz4FXyYRjIxA8bI4K?=
 =?us-ascii?Q?w1p2PGONDxWtxtdxXQ6gG16XxGrYyNfNo/WB4bTf/YmM6LK23p1TkGOBmrr6?=
 =?us-ascii?Q?desS029ikRbtoOYLU7JC5YHg2no/RtI14UdC1M7IKQnmLDpeI7thea0/oImM?=
 =?us-ascii?Q?glS4DvJx8ysjdwzT9Qd5EavGdqmYMHWliCqIcoC/4tC5PVG1bObxRQ2S7aIP?=
 =?us-ascii?Q?4zUxuGgaE2CnBkwmx5NiiKVx/I6LtwE8FyjF7jq7HQiTqDl4LA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnrJTIPOhjLFCQJ4yz94fHvgkJJdO90aU51QrjwfNE2g5RwMFtZqe2zsnQms?=
 =?us-ascii?Q?CeaCjfgjTmBTwaHXk5GratEV2IGGhnD1DXkHRgcNy0wSGwkHDx10AbeUx8kj?=
 =?us-ascii?Q?kZIGELrCoe547UZUZlA03OCSRIIsNpGuaDahAD0d+IyBOiAZQpxUZTKQp38K?=
 =?us-ascii?Q?9NRkSTzSd5Erv/QuCH5UM9kj/g8LSxnNcTLUD/1s+Ac1gOKLzqetycZKc5H0?=
 =?us-ascii?Q?35UvlHoylrRZVLAbutQcvyY7HctR4oomvupqOyNJ8sGUf8UlPjehTDAgv8lz?=
 =?us-ascii?Q?+plEdTaMxrL71gNYvQCcwNMGrF78zJcHcK6OKlIxT9Ph/ISmGhTa9K663gXd?=
 =?us-ascii?Q?zhWX5pGP45E/HwX8ThQ5Zq4LJVVyOIBK2Ftxx712KV3J3FdVhGj0Wxruti8V?=
 =?us-ascii?Q?iWakKBv119pwcRSKaTbPRViJnPF+QN0QCrwry2xP2ECawJXPS9ut8pPAhdwo?=
 =?us-ascii?Q?5JLBXDEJxG9fhhu5LpYd9qWiKgo6ULrnGoMPGFGTXDzOJJ0V19CRj48LxjO/?=
 =?us-ascii?Q?3pW6NEIbrzVaLALo9eLzS1QOrAuLaMml08gQMz4kxW35n6ObsdVu/YQdxJrQ?=
 =?us-ascii?Q?Tl5O7oTgjAPKa+Z6rUe2g5jaUunVhZ7rplWeMljMWSDwmmZVQKoCTJcHH8dx?=
 =?us-ascii?Q?ukHH4GXuFmdUpaCADNOgrmqa4ypHf8fuF9W0uAnDbm3X3n/qikYeDHHVfleA?=
 =?us-ascii?Q?hnOeFRf1jyNPwQpZSy5DWym04rc0sOmuXuj1Y8JYIvbVekmWweZ5RJg9aEWO?=
 =?us-ascii?Q?y5ZrwQsLJkzxQE/GjUI6oIfhNMS5jC5QNUoekOlZnxWuKhao3WZ3JfwMjpZG?=
 =?us-ascii?Q?ag/E77ZsJOCd3BhsCFfz4yZ5895ehC8SdufJ3P8mY0v2BCOq8ssaiBXWKUPD?=
 =?us-ascii?Q?GvM7X1hz9Y4YdB+mdur9FkIRUBqSr1Q3/nV3jIb6ESYdkxGGbPJDMfbF2eBS?=
 =?us-ascii?Q?xco0mCJDSvSdWJkhuVxjdnycKgfjIRxX/ZL0Z6oo4UyqhuYJonvIq8wFg+zS?=
 =?us-ascii?Q?9txArw8UrzCvq85h9IUZ/byAGFEK6FfuH1wMdQCoZLQPAT20igspqH1/MeGU?=
 =?us-ascii?Q?iiEbfHHQZgI6NDNmU3xpXMUugNzWpUYA90L+ZrXcHAd8bEbVKJjP1OA0Yyfs?=
 =?us-ascii?Q?nH/3Nwaj1G/isDGkL2Z4qBoPxrRBy1vlD3EL5BbJwmmNzl8E8pAaAwVXI7+U?=
 =?us-ascii?Q?76b2xKtpAi/LyBr0iu/ZvMO6s9jZap54FAZv249xtYFfBdb2QsKLRdBTRJDK?=
 =?us-ascii?Q?aU5Nt+cB2+iE5bBcvqOE3itlqpTfKKn3V5jBw0QmCH97IQk2WfkFNQoT3DZk?=
 =?us-ascii?Q?Z6uNIf4hl0BPStxP/fuRpOvE5aQiY6WYdSEwJSr6cJhS1JPk7SuVXpcbzuYm?=
 =?us-ascii?Q?d9ndATsVHqTYTGvWkAw+3MrEuaknAxfNKQM4Ln7yFicpGO/y0x1N0ipwgEin?=
 =?us-ascii?Q?GXSmNXThA8ohAj9TThAOfe7gYL4wp0A+u9kSizAYJvc7cw02fRUkAI2Os4to?=
 =?us-ascii?Q?87P23EZnMppDZnMTrxps9knxvGbhbMcLyeyuCbpxYWzBe4pcOSJ5ub+FDvAE?=
 =?us-ascii?Q?iI0lMrzEcJLbVw/Imu9QRU90VDs/WXEyAISU9l/DpB12722Web/qmKFqG9EA?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5937E92CE07B55E73C10D09EE5B92DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec5b52-81c8-4854-5c74-08dcb77e34a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 07:46:25.6615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmurIe0Rvyz4wG1SzG6AhWNdRWbBdcy2Uj8oOIxej9OWnOXYTME07uf1TyQ8A7nNi16wk/ATRjJvdoTEuHdFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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

--_000_DM4PR12MB5937E92CE07B55E73C10D09EE5B92DM4PR12MB5937namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com> and @Kim, Jonathan<m=
ailto:Jonathan.Kim@amd.com>,

Could you help review this patch?

Thanks
Sam

From: Samuel Zhang <guoqing.zhang@amd.com>
Date: Wednesday, August 7, 2024 at 16:36
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram fa=
il on SRIOV
Ptrace access VRAM bo will first try sdma access in
amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
access.

Since ptrace only access 8 bytes at a time and
amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
it returns fail.
On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
is blocked for security reasons.

The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace
test case on SRIOV, but also improve the access performance when the
access length is < PAGE_SIZE.
len > PAGE_SIZE case support is not needed as larger size will be break
into chunks of PAGE_SIZE len max in mem_rw().

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 5daa05e23ddf..a6e90eada367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,
         unsigned int num_dw;
         int r, idx;

-       if (len !=3D PAGE_SIZE)
+       if (len > PAGE_SIZE)
                 return -EINVAL;

         if (!adev->mman.sdma_access_ptr)
@@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,
                 swap(src_addr, dst_addr);

         amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
-                               PAGE_SIZE, 0);
+                               len, 0);

         amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
         WARN_ON(job->ibs[0].length_dw > num_dw);
--
2.25.1

--_000_DM4PR12MB5937E92CE07B55E73C10D09EE5B92DM4PR12MB5937namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Hi <a id=3D"OWAAM089762EA1318B444A77BCF5A836F9874" href=3D"mailto:Chri=
stian.Koenig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a></span><span lang=3D"EN-US" style=3D"font-f=
amily:&quot;Aptos&quot;,sans-serif"> and
<a id=3D"OWAAMFBACA44642CE874F8BB5502F1092736E" href=3D"mailto:Jonathan.Kim=
@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Kim, Jonathan</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Could you help review this patch?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
<b>Date: </b>Wednesday, August 7, 2024 at 16:36<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisible=
Vram fail on SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Ptrace access VRAM bo=
 will first try sdma access in<br>
amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio<br>
access.<br>
<br>
Since ptrace only access 8 bytes at a time and<br>
amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,<br>
it returns fail.<br>
On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write<br>
is blocked for security reasons.<br>
<br>
The fix is just change len check in amdgpu_ttm_access_memory_sdma() so<br>
that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace<br>
test case on SRIOV, but also improve the access performance when the<br>
access length is &lt; PAGE_SIZE.<br>
len &gt; PAGE_SIZE case support is not needed as larger size will be break<=
br>
into chunks of PAGE_SIZE len max in mem_rw().<br>
<br>
Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 5daa05e23ddf..a6e90eada367 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, idx;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len !=3D PAGE_SIZE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len &gt; PAGE_SIZE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.sdma_ac=
cess_ptr)<br>
@@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_b=
uffer_object *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; swap(src_addr, dst_addr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(ad=
ev, &amp;job-&gt;ibs[0], src_addr, dst_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(adev-&g=
t;mman.buffer_funcs_ring, &amp;job-&gt;ibs[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(job-&gt;ibs[0].len=
gth_dw &gt; num_dw);<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5937E92CE07B55E73C10D09EE5B92DM4PR12MB5937namp_--
