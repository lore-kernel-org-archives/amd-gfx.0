Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 12:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DB610E49F;
	Tue, 30 Apr 2024 12:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3Z9qShI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B65710E49F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 12:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR7ebUmIygYYN1kbCXqmBLkK3ZjqViis4sbMDWbMHtepvozsQUrha0+/SlCvU4sGwrP69ajRyLm90eftCnKBDua9ctC2jD/vLVMQvo90I3DZKTyjVt7M1AWwem73NGt3lbznFBDn1B6sfaq1/ynxAy9vsvNbAiutTSQAx6KLDn2WcuMLG22tKuuemPSVXFNNu0EjeOt+nD503G2Bk5+jh3SWWnDVI3JgBQHzq4ygBM3cYB5JC3WoYzfGrzaGWFpjHMSbRy8VN/sNClImY8JoA6UpDVBoWH3cQYGVWtZWBv1uwJh+77uJLaR9VFha9UZ2mkbUO2MY8gfBEyqMSxodqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FdvoYdUwX5HBHRL1XcbFZ/fAZL5AhuS0atghdCvEbw=;
 b=I2XdCeSS+uhThD1OOpe7ktA1WuP9eWz349aMbQAVJpd1rFwtlcs9RiAVFAFD/GOk9FQS3aVDYqitHPfTpB7Uw7KI7pCacKVBdDU/mi+EWnfPe9vQm5HLqaQXAffs8N6lqm5ZAvSiqH7itOLpnlvOByK9jci3lr51CRHV1WKVnGd8k0FOXq215HVW9hGgH8N/lw7k+Nxkmo8rpo3CezF4muaahx/ov8iMItYrgGkplVdYz3NOWBCCWg9lckbLC96sJ+yrCjR/2/AHmD2HS5fHJ8ecgGB4tXg3cIP7YjHgX95n4eml7ROnBiscYANgf26fsMLIWhXwpHhR9f3FKbNj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FdvoYdUwX5HBHRL1XcbFZ/fAZL5AhuS0atghdCvEbw=;
 b=A3Z9qShIxxQtE0yU3uWQScPB70/+Sqw7WBB96TBtd0Rm0IMM/V+9MKfQeI4DZ9SbxOfofD6nyppnJrPtX4Gs5LMiQVW4LxdLJa4NXVvnwRQpEmbBvLQLMpQucQHb1/V0qd+nslSt/ECf3bGkZOh1VGCUmfVk0V2p3VZpW31GL48=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 12:52:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 12:52:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Index: AQHamVIkVbroNlZbU0ymhztd0gLDRrF9k+4Q
Date: Tue, 30 Apr 2024 12:52:47 +0000
Message-ID: <PH7PR12MB5997683F2040661A1E05B7B8821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240428095435.126980-1-Jun.Ma2@amd.com>
 <20240428095435.126980-2-Jun.Ma2@amd.com>
In-Reply-To: <20240428095435.126980-2-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b957aaf9-3447-44f4-ae54-56c1d208915e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T11:57:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4316:EE_
x-ms-office365-filtering-correlation-id: 1132d60f-d542-408e-b75b-08dc69146f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nlr3hQGBlUgxv8IHbel1vnsY2pvq3pjdRgQfTyRGukH31keeTFRUIIpiqJVb?=
 =?us-ascii?Q?9HX+Wjse1hiUuHUDfpe1dmGiVxesb0dThzWz137aTLcFAw21xXPGeLN9v15f?=
 =?us-ascii?Q?fFQ2RBw0u3iUfo+WqBBxKYcELCgmdKIL0xM6c+b7qpTlQOk8GoZpLvC3bawU?=
 =?us-ascii?Q?yjN2udijeLp7ApYQR9GamUZRQuVfkcgEntegYQFbe1xQVst37JgkYq2+EGzW?=
 =?us-ascii?Q?eIU/9MY83QEBKpfDlPJHVRzN2e17xejSmtzWGgVUhHHzX2hvH24LCDlhRkLK?=
 =?us-ascii?Q?u4FMSRKypFwfGEZfX39HO6CegegWYG3UY63/4t9Wsh3IwoyJSk1YS1Efdfw7?=
 =?us-ascii?Q?8iUQe9ymvnG3U1762gp9iW+8QNSirJGpLCx9oRzmj9Em1GJaM2Q8t+hRXmw1?=
 =?us-ascii?Q?J7HxoUBbKDwBMGL2V1HaK64QPpLguKlQ+b2O9GCfUm1qKbEBg82I3bAenLhr?=
 =?us-ascii?Q?LOsFyJbSnWzNM8+/Z6uVshcRZEMdr+dEF0lAUP2WGnPbzrXwEzW4tttKsuGP?=
 =?us-ascii?Q?SeCw5UPdPGOgX+LPYH7kxiU+3oRZdPCkKLpYuvLGX8MSw945f7mzHjAFmvWp?=
 =?us-ascii?Q?qELYC0KXjHutHaPfYJIWMo0aMM23OkdJoCJe/sLFIjDBlIWnhDPDJ1yyHwO9?=
 =?us-ascii?Q?9MbeDB1FOM3+loo/dVXK18bttt7js4ZjLHvWcRtnt8ycwY7BA7hLLDn8P/X7?=
 =?us-ascii?Q?OS42ZeUqyWbOIpHNxXckhertiA0ncXo3224EtY8GE+6AE/Oofdfi/zGNCSvn?=
 =?us-ascii?Q?j/S9QyBqy1Uj2jMbykO6zhwf60QKMCn30LxdizdSVX2Z15A0/R1PM2mMGuIK?=
 =?us-ascii?Q?jcNMNS8xk9ZN9aShKu5dT6qHLaQxg0Al6brXg1K2iSxYkSm6szikEDcMQlz8?=
 =?us-ascii?Q?82a/Oi4wUQGxoaMTQlURz3PAw8lltqhyJbLEa4HKQmteBKybqgSE15ojX2ps?=
 =?us-ascii?Q?bkkvZIB4AdmnbmaKRo0H2q6xzr5jz6upQ3DzE/1XsW7vyvdhZF3c9+FVoe+o?=
 =?us-ascii?Q?+55Cxx9+nuPmQwz+wJ4dyG4aU2drHSkyfVWcOZz5uKBvv6IfbU4QWiatyxgp?=
 =?us-ascii?Q?w9zeY+F4yA76KoEiDNRvI0caXTMdFb9DPBuMpanNkU3kwsxA6b6TapukO6xw?=
 =?us-ascii?Q?Zd2mn/atjrBVe9NWEUbuRbpbw314HrR4ToiPIa5MYPSObUKRMCk1O7oi0dC7?=
 =?us-ascii?Q?6FHQ8/s2h0pRnQa6QNvz4eoJt40em+qzPjVUnMJhzE9B8C2q1u+YJlrzTHPD?=
 =?us-ascii?Q?Rtjxe2hyF50PyhXPxU6lL8VRYfH8CpOlsvuBvmxevdxjs4tJH+PfMfTCJilG?=
 =?us-ascii?Q?1Tgj2qEFJmyLq0Q9EIhTkD+G9vmNP4u6SUDKfIKvgg+R8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vw6Y1xGlhV15G/U6TQK7HL1V+80a+BIRe5ejUghNggvovGoJHdEQ412BPz0u?=
 =?us-ascii?Q?vn6PJYylqqMAmvJ+2AyGT8+1/3LaR6ue9UkpZfWAJ1DCZNuj/ese7zUsTbI0?=
 =?us-ascii?Q?izev6NJO6vVtG6k+ee819Szo43+h64rziIlqFNXY9bO6l4Tvnx3jukG5XuPL?=
 =?us-ascii?Q?RIy3qVOWsG3tO24RbRp7Jcg0hTXGYMDSFnoX3MUYGhXKkgSe1uX63y7dA2zk?=
 =?us-ascii?Q?rIcleSk2VJfTCB/KONjDRn8XflmhYIUER0wztPQmaW9C9HjhnqaBGz27Rkh5?=
 =?us-ascii?Q?5RIjHz2/wfeJhOuZNar+1tk3Za/cLhuUJJdQqVdf2DJ51+HG4TVsFKplRf7b?=
 =?us-ascii?Q?n4poHD4C2ITTFf4CKTUelpObwLfiCESXPvDNdQG7pH1vfnsofuniYHN/s/C0?=
 =?us-ascii?Q?2OAmp60bmGelJEMe9EnkfcZCYVI2Q41waIG1unLc7ZkxXKQX/NvfvsJhDOMA?=
 =?us-ascii?Q?no0zGABugUi85byvYlajQcLi8sDrLsHIPkVvN28e45SmkaIrhIAz5lABoSqH?=
 =?us-ascii?Q?DWfS30MlMpTpuYSXOka+IVwPICUOdKmcKRHVvrJJEHmQJd5l5IG0E2qD0iLJ?=
 =?us-ascii?Q?9xBxycIOG9qmYnFBZgJoFdrRjGV7f6+9OnQS4TnYKvjTdQaQTZdJjZgJe0N/?=
 =?us-ascii?Q?AapJ2iu4iu///gAMSCWi/7kdxvYLy9oF83ODAo44wAFyBmw9oa3EIji31nHo?=
 =?us-ascii?Q?Us027xtZfEa7VejhMlc7GjSyiOR6Nz4bjqIKSsjkmSfRitR8rS60hIuyhAzy?=
 =?us-ascii?Q?23MBBev5qeTA+1LNWfdm3ae8ddCTVSjtvSeKCaBSOLnYuhknn+FEFXYVnYmJ?=
 =?us-ascii?Q?NzEkQVDW7Lqibm3L8/DfcEq2SuXUW0vxd/L4/mvufroUPhRbjiFpa8Pa+tru?=
 =?us-ascii?Q?iZSkjo+1z+F1Jy23XAvtU/TPIglvPS48wU25Uax2Q/3JxoM+Y9BIXkczOc0m?=
 =?us-ascii?Q?yJU4/X5HSm8Fpquz6lGOgbenroTNqDiwUzIMHmrHcwwaKiqA1zLjazxFERON?=
 =?us-ascii?Q?K8DQi+R1wcP3Lr8FsLbaTmt5nr0v6ShtusXcXANERhpJs+JffmBQxpmqFFie?=
 =?us-ascii?Q?fO3oDoQ63xYRNyquI8U9A8mvnLueh+dc5KrCco73I7IUQsXGVrRRVffNmaNp?=
 =?us-ascii?Q?D+VZdXmbZiUBCB+v7R3aYKQh6xkw9/O8w2kVSuWtEF5v96ouRp5/ZSVqMpJg?=
 =?us-ascii?Q?FTaKmYywyzkjI2DZ0VA0twhcrur+VxAp0ifO0T1UD9pNCMcuYNPKmkmorQYr?=
 =?us-ascii?Q?GafXeDuuwMVloKyuzkGcpaf/tEz0vN9PGNgeO5tj2MnZFsg3oghtavpcvGOV?=
 =?us-ascii?Q?yQTVn2N0sSBLFvmS2oRdziKAqIzTDZgC+POphDoZ6J0xkpQI+I4im0wD4VXA?=
 =?us-ascii?Q?bRm3fpxlFnxRR3+BkwJv8y92tcOu79A5ntRc6ky4OwHSekp5JJRZ1T89zymF?=
 =?us-ascii?Q?sZ9nUTGmGT+Lx/wE7JxCVt6iMuTpixW13OsifZm8WQzQViYomaCfFXyC+wyi?=
 =?us-ascii?Q?5QapcwhdGiUvqpa5Y+J7fNjZ3u06pwW2yd9bVDWnN8FIUZ8X6UfP2cV25DGN?=
 =?us-ascii?Q?nZwznezxguaHP8ekMCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1132d60f-d542-408e-b75b-08dc69146f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 12:52:47.0657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/J5M7u+aZVe0Wzl0pjq0k7gXpQEgF16xhIhdD8hNqpm+ca0Ica3ez4fXSy6OBpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

[AMD Official Use Only - General]

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Sunday, April 28, 2024 5:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning

Check return value of smum_send_msg_to_smc to fix uninitialized variable va=
rning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 ++++++++++++++-----  ..=
./drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  8 +++++--  .../drm/amd/pm/po=
werplay/hwmgr/vega12_hwmgr.c |  6 ++++--  .../drm/amd/pm/powerplay/hwmgr/ve=
ga20_hwmgr.c |  6 ++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 0b181bc8931c..f62381b189ad 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1554,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                }

                if (input[0] =3D=3D 0) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMi=
nGfxclkFrequency, &min_freq);
+                       if (ret)
+                               return ret;
+
                        if (input[1] < min_freq) {
                                pr_err("Fine grain setting minimum sclk (%l=
d) MHz is less than the minimum allowed (%d) MHz\n",
                                        input[1], min_freq);
@@ -1562,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                        }
                        smu10_data->gfx_actual_soft_min_freq =3D input[1];
                } else if (input[0] =3D=3D 1) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMa=
xGfxclkFrequency, &max_freq);
+                       if (ret)
+                               return ret;
+
                        if (input[1] > max_freq) {
                                pr_err("Fine grain setting maximum sclk (%l=
d) MHz is greater than the maximum allowed (%d) MHz\n",
                                        input[1], max_freq);
@@ -1577,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_h=
wmgr *hwmgr,
                        pr_err("Input parameter number not correct\n");
                        return -EINVAL;
                }
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency=
, &min_freq);
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency=
, &max_freq);
-
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+               if (ret)
+                       return ret;
                smu10_data->gfx_actual_soft_min_freq =3D min_freq;
+
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+               if (ret)
+                       return ret;
+
                smu10_data->gfx_actual_soft_max_freq =3D max_freq;
        } else if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
                if (size !=3D 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 74a33b9ace6c..c60666f64601 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2486,9 +2486,13 @@ static int vega10_populate_and_upload_avfs_fuse_over=
ride(struct pp_hwmgr *hwmgr)
        struct vega10_hwmgr *data =3D hwmgr->backend;
        AvfsFuseOverride_t *avfs_fuse_table =3D &(data->smc_state_table.avf=
s_fuse_override_table);

-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32=
, &top32);
+       if (result)
+               return result;

-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBotto=
m32, &bottom32);
+       if (result)
+               return result;

        serial_number =3D ((uint64_t)bottom32 << 32) | top32;

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c223e3a6bfca..9dd407134770 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -364,8 +364,10 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *=
hwmgr)
        }

        /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top3=
2))
+               return;
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &b=
ottom32))
+               return;

        adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;  } diff --g=
it a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/dr=
m/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad807..3a95f7c4c6e3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -404,8 +404,10 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *=
hwmgr)
        }

        /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top3=
2))
+               return;
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &b=
ottom32))
+               return;

        adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;  }
--
2.34.1

