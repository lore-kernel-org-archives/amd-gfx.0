Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24BCDB474
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 02:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8678610E358;
	Wed, 18 Oct 2023 02:37:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8C610E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 02:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2TX6DreIR8yqIoXI8kAf32vWOI1x6dxQicMg4UN8K/6qmnX4OwhUx0nQhOD1CLOUyCtwAxBt0GaczsB4lzaqensi0W0Ye8NJhmTZiEHB+EfaO0zqcxNqdPxs5M2/OFdFnRVWhdSIjeF0KkRnkPWs6uvK4QFXyxoCrmELG6FhqD+H2CQ1FpORw4/KbHdHaiz0EjtKjoJTW7saX0r9k4AUzx6imouOiAc4rJH0lI2+qBX9xJl02m6IZLd3NtmsBVvalJn1AlaKpGKKHA31s9R3HI4rfVepbrTnK8Q5EdgwhCdWxRPiIegJV7AOaNaL45W6gspD5v1gBuQiX5IjG+Aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGJl6tq2V33hScr1DrpeBVHNi9nGFhiUU25gg91cUy0=;
 b=Vh0eJYo14W7zL47PBWWRAeFnPuEJiqO+pDW5E1381G2X/VI51WEqJrX6o+NxCO9e5bCnzLiXBUxI7KYaovfNpOsJKn2OgWwke58+L9eFyhQHe6uOUqEao/gDZVt7Uu7yXIGYWAHPwfpZyE0SUNQdRZUkwQugSNR6JI4dyPrQOA4+b5hZ3qORf/pvKea2xt1U8/2Wu8smVDPyaiDq/xBFiutzjFVDZYKPoQjJ/MhObp5wuU86bVvimI4lvJPCygaTuoXLz3ig1+gMJbttUKMUckRPzB9Ufy8giguVJlTx6/fRIuDypZ3BnMl72oQhYJKMqANsS02UULFqQ+waG9fxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGJl6tq2V33hScr1DrpeBVHNi9nGFhiUU25gg91cUy0=;
 b=c9INYeNT/rqgUuNlaY2HAj7LY16R8UdDh5iu2qzOZaOcuM9OiZx0ZPhUTZrx4bGw3PeEXhnheZZsyGPRktGEEA7dHDO5Dl7EVdf9yv5csPgbvMIl9LNY8KLWu0bnHfZ5/y55OZZzC3JKsaRvZh4paRqTixiVEOJM8JLAFXo7sdc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Wed, 18 Oct
 2023 02:37:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 02:37:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Index: AQHaAQdgJ8QCO0vTJEenzicXEnFqKLBO1gDQ
Date: Wed, 18 Oct 2023 02:37:51 +0000
Message-ID: <BN9PR12MB5257F2DF9095032D4CED63FDFCD5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231017143638.3203961-1-Stanley.Yang@amd.com>
In-Reply-To: <20231017143638.3203961-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=44bdb7df-3884-4610-8213-78e25d2f5eca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T02:37:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 53724a60-93c4-48d1-5ae0-08dbcf833952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/f6+OrcHOC2kxFA1bH+nCkrDYFJ2Ro669UueNj9zz8i+U/208fW2XdqNoO72UJN+/0A5xNEkCcFuQsyw1DghKh0zWYaL3qq3OiZvo/Rj8DDWFnOwOYpChSmcDUKrazcrNE6IEvl4v3GDJbumPr6HUXuPzOpsaqyHLrHQ+UuplNXAJRLdIgyu51B0KZ7iOiB3HcPSrhj4ljJgFwK75hCVW3pXO7rylGRz+qhC1q9DcoJHcRLnwem+3Tw92CeCwOrR8JycBOyQ7Z9lpPTvnnflho0VZDCGr1fmTDpp+JhdK/uRRChBEx5k+OZ3i7V/34y/FrKHdsxtGtUa3ibnWZ50wZlz2wSANOHMzDRILtrQxLQcLG4yJoMHufE+0vWmOzNhoqoKGIlr0bZI3rFxsSvKmvE8rLJQudQwdKyDRsy4f52Ow5mnRPsnDKbVoIQNmkwJsj9xeOYqijWM9FRiID/skBNG63ohPypGDSKeoTt4bLGlMhZ/w72Liy9ZsxLgaTW9bI/ZPHL7rSIpj+63/2oOG6Xu9NRoaIhZj8L5yHVzPweTWfFjy+VnZnIAZFwf/HSg6VCu6VsFaTSOJv0aGAK1yFdOBqqHb7AjbbcKzScWTe+eG1JGmFhvGKXwzxB4DBe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66556008)(110136005)(66946007)(66446008)(478600001)(66476007)(76116006)(53546011)(316002)(7696005)(26005)(71200400001)(9686003)(2906002)(5660300002)(38100700002)(4326008)(6506007)(41300700001)(8676002)(33656002)(8936002)(52536014)(38070700005)(122000001)(86362001)(64756008)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tw5AvCaBsvM6JOZsiH35lDY/RehP9/cnZ5225Xdtu9dEj5TulO+48T1+SFCn?=
 =?us-ascii?Q?Lak9x5CfunX+L8PLzPzah6MTV4SADQwwkV/KwFzVDrQkC14m8f5eoV4vW/Ex?=
 =?us-ascii?Q?Fqm/f7ybhqZ7SAl1i5WosAGhWZXLGflJlhBeQ8N9gjw+JADaThJ+EG3yZ6Em?=
 =?us-ascii?Q?HcowyMYKq9+Qq17Z4I1YITU3JZqFbJzMfaWc87dUe4AOUtzCHo/JXeEMOm0T?=
 =?us-ascii?Q?yey07sj97bKhOCLA7r0BJRLsFaZWW9lm5PdVbftSLrU2NKTI9Yq2Aylbm5h6?=
 =?us-ascii?Q?2qne0Q568d/BOdHRT+8vCHEVMzEN8kVFYcjfwlziD5BcCz6OWcR3rvuQDHsI?=
 =?us-ascii?Q?Hn+8foBtvnAMhHsuytfZpMAValZB31fAXjR2146V/uUVocwCdgX3WBoTdj6/?=
 =?us-ascii?Q?7kEbH9BxA4pnntn24sIHJnSO0qscA/LAyldQQLBqME9G63hAPxNDtKY3ngGk?=
 =?us-ascii?Q?9TkTFAe0obvhWJpdPz6CBk7R7jLYNGdQ2GskGDkWE1Rm1uRbrazA7QuKAgAs?=
 =?us-ascii?Q?vCPe9r82Rx6QbjpF1bNpis7/CqNyHYm1SjaqT2qmiI0wmFK0qhRo6I+zJq6E?=
 =?us-ascii?Q?UKeCsL8xoe+ygQZNNzP13kb/DKVM9B/BDo2V8XN0B3zbHXD+FxVhR9Xe0q34?=
 =?us-ascii?Q?2G3pn6TrFoZATwtb8XCC4RZdR0/E8tcrZP9w2uoO9nQtE2rNLkCx5r10DSuF?=
 =?us-ascii?Q?8eFDmqChfexaBUPKWD5XtmSatkoZefKloOYudeXtRiMnVpDNhNsXy5xhOUSV?=
 =?us-ascii?Q?VguLOzP8QURKjGhF/Y9S5ixxP4xLSqU8SLDpLSY81rlcgOYpwvqeytN/iCo8?=
 =?us-ascii?Q?XzSRTycFGouQ+wzWUV19vIoD9qY6U0SWp1p5nyeTK7Hcu0GdbYoIzEFxtfZk?=
 =?us-ascii?Q?3eTaw5JS1QQaLaHqdAx2dqkZA2oUTb2SWjxzurDDdmzTBvIZFTjTt56bnFJt?=
 =?us-ascii?Q?NHPpGwpkle1Q+XQldYx7QlIY9ELZ/nxRDHDa3H7KXAi5CsLTrAC6IIy1vZlV?=
 =?us-ascii?Q?dMa7KTex7pHycJFwx1W1Mo6UvIVE+OvUMpbe1ap9An3W2ZFw5lZtqFUkRir2?=
 =?us-ascii?Q?y2/OknRiQ9yddxM5fWbLvhSvrIcYuYZntUartrTwaNOPBqAxi3wSKGmgHAuA?=
 =?us-ascii?Q?hCBdgx5rjijLD3PeNTiBus4/ipp2WS2XG3rjdQregLkOEGF2M0MrfpT/sMQJ?=
 =?us-ascii?Q?yB8gWfuvpuCNw18+ayaBHrNqy9xnrk3lAMUCLboe6UFq+J71Fz9lE+asdBey?=
 =?us-ascii?Q?MLcfjPxI0Hw8C1ykBvF8Uo8urKXDxaAHr9xUfQ8k0Bxa/wzS1guaH3Y3CQpT?=
 =?us-ascii?Q?3y1cVWDX/X6qn7Ecy+kNBQjKcHYZb7BTwktHLi1kUsU/YcywnD9yipHQ0PfJ?=
 =?us-ascii?Q?ONs3Fy7zo5MSJ9kcL97WYs41YzjP/G8jwJiRC84xKPeiAz+EGxYOen87qFoD?=
 =?us-ascii?Q?EBH0Enlo3xYXQM3d9dQbPRG60MRVetWmOkhlE7HwlSAjn7c5ra5nf4ENHY1r?=
 =?us-ascii?Q?aqUnfO1WDCu80yG46dSQbOegjVjMBRSFZWPJe03JtbHwzn1LNYYyx1Wcaqpu?=
 =?us-ascii?Q?NSMiqjF2+XqVe9GHUmAhpcstYVS9Je2KZCxjihGw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53724a60-93c4-48d1-5ae0-08dbcf833952
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 02:37:51.2155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAT0VeoB33BZ1HjWGt5AMGDt+58og76i1SdnWhHFgAT824390h81niXjts98AQKCqRehOYaEv7eDrLx2TWA9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Tuesday, October 17, 2023 22:37
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test du=
ring ras gpu recovery

This is workaround, kiq ring test failed in suspend stage when do ras recov=
ery for gfx v9_4_3.

Change-Id: I8de9900aa76706f59bc029d4e9e8438c6e1db8e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 9a158018ae16..902e60203809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -29,6 +29,7 @@
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_xgmi.h"

 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -501,6 +502,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, =
int xcc_id)  {
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
        struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       struct amdgpu_hive_info *hive;
+       struct amdgpu_ras *ras;
+       int hive_ras_recovery;
        int i, r =3D 0;
        int j;

@@ -521,6 +525,23 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
                                           RESET_QUEUES, 0, 0);
        }

+       /**
+        * This is workaround: only skip kiq_ring test
+        * during ras recovery in suspend stage for gfx v9_4_3
+        */
+       hive =3D amdgpu_get_xgmi_hive(adev);
+       if (hive) {
+               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
+               amdgpu_put_xgmi_hive(hive);
+       }
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
) &&
+               ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery=
)) {
+               spin_unlock(&kiq->ring_lock);
+               return 0;
+       }
+
        if (kiq_ring->sched.ready && !adev->job_hang)
                r =3D amdgpu_ring_test_helper(kiq_ring);
        spin_unlock(&kiq->ring_lock);
--
2.25.1

