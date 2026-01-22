Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1FDC44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 01:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCFB10E240;
	Thu, 22 Jan 2026 01:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKKI6eXO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52F010E240
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 01:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an42p/ouIAmY0CIXPw5YWO74zRtslTnVmFjxmdjuabau9M0O93jfhWi97ugoymAuaxAqZYNaWeaFR+IdS5wQkk48HDCttwg84s2QcicuSzflwugnoFQK2TuFWfERHcgU/D4Q5isvHxsphSlyiXxx1Ce2L6lCn/04ztNVepJ765ol/rIZeznqKZJ2uWC6WpwBJVCbbtV6fp+a3JnoJn1zpViQd6pbuPoUTz2Cb51WEXPy18cXWrt8zbRQSuxtAwG5v2GBTZn2dFfdMqySBlpoj+NM3+G8ePmY6FNnWj18LvsYgL34qouzOtddAvvmTNK/L0C4n4GEdIg1CGWr3bJBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIxOVVp5dCIIS2LUekOjaruoeSGOESML6kNIx5r9E20=;
 b=EDxDxQVqtweFf7z2JlJtLXKuB3yrt5aFAv11zKRIlJIm3GkWT8lIkXZaq03J0HtuU0rud1m7vhAPxNhY1m5fT0xrHHv5Afv92VPvaybfoS6nk1uLV7xDeQ3dm0l75h5ZZPm3RhHTI+w2dsGKmSrBL7GHf4uxUu30c+PSenpTHdcgnivE8OtgNh5HUwv/MwjIIe2m/mdOqjRn+bHUvi7KHPlnjyAqu6CHCH2ELD9uWjvSMu8yblmR+1PsEIbkvC4WDwmgadMGy5LXxD4i5JKujaxLwwHSRPhLPGGHK/NoiThW6tSdRu9G5sRMcUnk4wGNdqDzuWLOayzWxypOWPRNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIxOVVp5dCIIS2LUekOjaruoeSGOESML6kNIx5r9E20=;
 b=CKKI6eXOsCEDGU0G7rBzhVxFSMR8je9wjF79H2J49qy5wQ6kY9Q0j4Yz09WuFCrYC7A+QVVb4sFiQJrOA6dmqXZ6kd/FgoPGBH+waNgse08IqS3ic9toeFDA5JZueObC/oDWRAo82R9tbfTKBXwDWKzZw+VkN9kehhe7CwXbRgg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 01:00:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 01:00:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"
Thread-Topic: [PATCH] Revert "drm/amd/display: pause the workload setting in
 dm"
Thread-Index: AQHciy0njx+51jHf/UCrjjxbbSSdW7VdXoYg
Date: Thu, 22 Jan 2026 01:00:36 +0000
Message-ID: <PH7PR12MB5997E86439A7760F300BF51C8297A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260121232444.59107-1-alexander.deucher@amd.com>
In-Reply-To: <20260121232444.59107-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-22T01:00:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB7141:EE_
x-ms-office365-filtering-correlation-id: 0664c692-025c-45fb-590e-08de5951a79a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pPev5QGAMdJVrNv9DgSNaaENPDJYMJyWyEWnha2uOY2EuEkT5QNYL28ej3s1?=
 =?us-ascii?Q?bsvhwohUXzIeZ1xQ+FfarjehnKZPVK31q9kdkIHtnLBI3mBnYB+tklGVcbLe?=
 =?us-ascii?Q?u+36PaaZVQQXgcvhXlCkNwfrFgHVD0qsR6vT8ARYdMPAvnlEC+nNMSwJmM70?=
 =?us-ascii?Q?y88lcdPnH3GCSZ9yhRU1Wea1EiNPpdmcD+A19I3KKbz32xH7uBhG4EBVbF6u?=
 =?us-ascii?Q?VuwOfFxPjGVC6DBzi4eNJynboK7PFWx2khQGvAWrkgyt4a2FO89F3H2hHc9O?=
 =?us-ascii?Q?lvnOCfeu6jIrjjOUUE+Yfyx7KYUv41xaVi7+5QOTEn8OHzoJybii7Lx8/x2+?=
 =?us-ascii?Q?gvsiPjaQbneZdoJHOTfRfd6gHWMEvJBHfGzjQI+TKrxuR35MvXqeJaQJdn8/?=
 =?us-ascii?Q?ZOPx/ZXrn83fEPREaWeS9VHrgKJZYvLK5bnW7pWNceO3JA369xzatD4oCdaP?=
 =?us-ascii?Q?XyYZR0SSmySTE4TJPiHI23g8EK8tfUeiOxZmZiK21gtjsg9UcmhnpI/lS1z3?=
 =?us-ascii?Q?7dWTf4ZkOIeqZ+5dzb1Xuos1GbPkEolQpfE3B4Ms5vrR1IMpPl6Qe6rK1mtO?=
 =?us-ascii?Q?lpLwVnCURY+bXwL4iaBd1GntxLlA7x6jYxRAkhZRp2I9st3+O541ktFUVsyA?=
 =?us-ascii?Q?iWIlje3qKBOGqafF5Uu88yKSk9MOvP0Q7xvhcQbupjpLoaPVYRtA0epkISqH?=
 =?us-ascii?Q?P8zzbqdDoKDSBmwvXoTFcXgIiqh5zJp3ZXLhQr3KWiViUmUpLZfDw8oYpbkw?=
 =?us-ascii?Q?SAufzrcpMBbmmggIbebodDHiXem7npu9ix78i3dFTZLXjQsmSonk9KLWt76S?=
 =?us-ascii?Q?PQNaVQCgnjzw+eXQZ6C1Gk6IHkaiAk6gYZm4zQmR0cb/UfFUpIe7GY7YTbCp?=
 =?us-ascii?Q?i3JHpw2vZv6WYsSZ6uGI20b2dtjNIa0iuTHmWdYLDy1YJ7t/eXrW/7B9+HXg?=
 =?us-ascii?Q?64HqhaDx52Xh+19mkIbZl1/SLuXsFk0tVBpOv9Aad5shSdJTEtCcovWr2BT3?=
 =?us-ascii?Q?sIlbrQLxHnxQvT0lAJFF953493bY/UUzNJBd6GZuoviw9FgESj/sIEqWJrLm?=
 =?us-ascii?Q?+V8OXxRsQ9rRzmbGE5VNIbtz8ivlQ7KtPYalTydRdOfmCQY9tzt0SwP5yfLp?=
 =?us-ascii?Q?ExZUBU07bEXBpuAdqDmvE3Di2y1VoG4f6Kgy9dRtvFwSW/LqTseuqNr27RLx?=
 =?us-ascii?Q?pmUleLCdm8iPMzW3talUAJ6iBkr7TOSxuRWUywMAW+mmyacXvOCVQSKclG6Z?=
 =?us-ascii?Q?gkG6C3OT7VirzsspdMpdid8WTi0Mb3gAQTPCoXcjF0IospT+S+1krjSQIZab?=
 =?us-ascii?Q?qSocGP4QHjidE5hS1/3b1IyLAXCeyWIw8ZrMkkRpYlRubzGYKZbeslFFlyKu?=
 =?us-ascii?Q?PK6oXTXuq+Pb+EnQrn1c6RGkGYL5OMzIWjBGbk9HwIEd3Fp41cjgwSiuU7sN?=
 =?us-ascii?Q?at/eiprsLIz28esvk4ll8oDbs9dzhfVOpWzhJp/cWCOEdjvbzIoFfvCh0Vx6?=
 =?us-ascii?Q?ofMeaOR95+wrChWMMfzqRLv4m6BFTE7Udm6Bx8vK7j54eh8foE7kCtwuiB8L?=
 =?us-ascii?Q?1CZ8Pezkfg4BBuDMZI2V95ik6Vskeb6JHXJisG0rPAEisjri6jwRt/bHJ7Go?=
 =?us-ascii?Q?U1W8x6zSPPFEYx/VyKTEpxA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5nqtjE5j6sum5jtxqAOmwtqlS2ux0xcmtNhymUpPQgO0I8DgjwCpTmZRnO0X?=
 =?us-ascii?Q?xVFUhsu5fCZJny0DawbwlvIDeytR/oGwx9mvC9x9aMww6MYwRhtEPY29Hw3K?=
 =?us-ascii?Q?XA/ij0Yk/P8kv/mFQCJQz3A1HK0B2+IAfEIqvMZCmsl6C/L9SjJLSbOh2pO0?=
 =?us-ascii?Q?vWa25/i6L0YQuhv1An3C5UPDmcbJcE869cIUJ2+LrLHhtapzAjjg6HomJ0V4?=
 =?us-ascii?Q?WVyotwVm+4sKKskikdoOzC785vaOL2+x6KVIuy+Q6ZU6pwa3r0DyJrJGFloB?=
 =?us-ascii?Q?OSRQddEJKtyYRjX5QEs5+m9rdjtP4orSVOixepcLENzatW5Y/3kwSxdAlqk3?=
 =?us-ascii?Q?aEH2Ee1Cf4vkCiqtlyhBjQcFxfkAQvHcuhLUqdeXEHmfQGZ6S5Zgod9miLex?=
 =?us-ascii?Q?crhA+b3Ef/XJOjTZW2WBHOtoYbrV1WqMsBykDghqSctV19c86cnQ3zk54vpI?=
 =?us-ascii?Q?i1/YkDp58jNMnNPqPOEwXMgqLNb4R/A2WBiwTz3RfCzQwZpU7LuIH6vDohOS?=
 =?us-ascii?Q?5JjQDh6YpBpsBI0bbybgLv3K7SP5UXQvuQvMY/h+yGBpPit8wxzmpNAZbDgQ?=
 =?us-ascii?Q?auZXrO9VuoLbMYaHHKjACQOL9OoN8PMTbF4lL0biRCcudC4yEmmr677m95wx?=
 =?us-ascii?Q?21SuykUKzvWvWz5g41g1K76c0ZJ/eMAO+RR249+3mQWGX3WrSTQw3qFAHP7t?=
 =?us-ascii?Q?f3DcqUr9QjPn50MhkmithMBrEtDHi28uahgMHe2ycWYL5rMkPpehUHTyaHkn?=
 =?us-ascii?Q?2XEa3GKCz3tSnYZPRw0umTqF2/2/cb0XU6dtns+4NyrQPCD5HBjEvu+D5TaP?=
 =?us-ascii?Q?EbVey1E9QKXuW4MuC2VTs6l85USEuK+XWvqqeXX1uzOKMfj1VbcntsD2HUzo?=
 =?us-ascii?Q?bS0NJJJ2R66RNliNow8YJvJ6KFEwc2dzgwhb0Ok+zprNvgmwbgBfNo0nHu4V?=
 =?us-ascii?Q?Aq5NCzLeUNMxDPicVBVXa4NdNvDJRPvGH8wlSommgOTiYIW9+AAUu8rQtOwQ?=
 =?us-ascii?Q?5Ld6v2KdMdiBXTzc0kIRdsG7ltcLPx7nGaY9K0YKwA1x9VnLHX05/bZJgrYs?=
 =?us-ascii?Q?wN/HsMAfDQ5GazKwRvmjMOVtW7/r4Hhir/zdRg9euE4u+T1c+PLJpLe2Znw6?=
 =?us-ascii?Q?7LbGh/0LXmkIhhmQDctXWI9FzlXViO9ex8+W6ruuht2YoboW32wlUlhROYu7?=
 =?us-ascii?Q?txt0eLT0vjtNdGpOa3pQ00CqOdNFp7DwmYkwReZKzIF4UZPZksvQVqJeAjRd?=
 =?us-ascii?Q?CcvdH6M4HlhouTU2hfGw9+qpB8SKhPutMh62TA6R6EL/ey+8xF5y1Cwp1XYg?=
 =?us-ascii?Q?p+Prw3G1ZOJYLmAoGJlHK3Z6UvwINRrQPavdogmMlskfC5V1bexT6bNgJ3EI?=
 =?us-ascii?Q?KnDU1SOZlKy7RNrgpONMlC8gMzvX75ZzSoGpVWbHO5lecQWg6UvZ2jAITLx4?=
 =?us-ascii?Q?G6BbImU7vftLLm/qnZ7ZneZvKwrGIRhLLyHGw8wsfQ5rKw5JxBGJ3ZQDL4DE?=
 =?us-ascii?Q?3MTz7JhEDZ9Vphyf7312IlEp9JSwO9N5M5rXy4LuiYIaRDXN7iWKFwFxynTb?=
 =?us-ascii?Q?rZ2Je8V3UPoiFSTeKYiBayorc6A6MT7gRD9opTXENKF2H/vMCrpZTQ0NBwU1?=
 =?us-ascii?Q?GcOLHSLAVbTEJwQ2MtpW2L7yFqlMYGXaVOZHlmtKF2NDHIn/N4OSKefzOSJM?=
 =?us-ascii?Q?hQ64NeytqMf118DdYYAha46T27mIaGKmng6siwaFdEbw/emi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0664c692-025c-45fb-590e-08de5951a79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 01:00:36.9797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7i9A4SpHKhC7txoIJQyQ+oz4g+2JCLo0xAKBXAaS5hYUY70oQ+dtkuauC9OPF635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Thursday, January 22, 2026 7:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li, Roman <Roman=
.Li@amd.com>
Subject: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"

This reverts commit bc6d54ac7e7436721a19443265f971f890c13cc5.

The workload profile needs to be in the default state when the dc idle opti=
mizaion state is entered.  However, when jobs come in for video or GFX or c=
ompute, the profile may be set to a non-default profile resulting in the dc=
 idle optimizations not taking affect and resulting in higher power usage. =
 As such we need to pause the workload profile changes during this transiti=
on.  When this patch was originally committed, it caused a regression with =
a Dell U3224KB display, but no other problems were reported at the time.  W=
hen it was reapplied (this patch) to address increased power usage, it seem=
s to have caused additional regressions.  This change seems to have a numbe=
r of side affects (audio issues, stuttering, etc.).  I suspect the pause sh=
ould only happen when all displays are off or in static screen mode, but I =
think this call site gets called more often than that which results in idle=
 state entry more often than intended.  For now revert.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4894
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4717
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4725
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4517
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4806
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 38f9ea313dcbb..2e7ee77c010e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -248,8 +248,6 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct=
 work_struct *work)
        struct vblank_control_work *vblank_work =3D
                container_of(work, struct vblank_control_work, work);
        struct amdgpu_display_manager *dm =3D vblank_work->dm;
-       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
-       int r;

        mutex_lock(&dm->dc_lock);

@@ -279,16 +277,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struc=
t work_struct *work)

        if (dm->active_vblank_irq_count =3D=3D 0) {
                dc_post_update_surfaces_to_stream(dm->dc);
-
-               r =3D amdgpu_dpm_pause_power_profile(adev, true);
-               if (r)
-                       dev_warn(adev->dev, "failed to set default power pr=
ofile mode\n");
-
                dc_allow_idle_optimizations(dm->dc, true);
-
-               r =3D amdgpu_dpm_pause_power_profile(adev, false);
-               if (r)
-                       dev_warn(adev->dev, "failed to restore the power pr=
ofile mode\n");
        }

        mutex_unlock(&dm->dc_lock);
--
2.52.0

