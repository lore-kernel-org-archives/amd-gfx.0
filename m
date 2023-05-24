Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6456FC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 21:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C6610E0D5;
	Wed, 24 May 2023 21:17:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFBC10E079
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 21:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrJj2d+B+1sSNp22qJWcLBo1J+4i+aA92LQ/vVuLE2mZBhzu982V5Y09e0/q3TJ+z2e0TkcDhe1rk5WzvI417ff9DBqo3RxvvkTlbUO92NE9jx3dU4jZ+iyb6IGkKms/OWpeyipQ/tH+3a5UNPVIy71tKjO8JN1leqED9nU5fubeum0oOTZYx5g5wxRJy/M+3qQX7q/KcFYu2f0DaSCBaI08bJo8rAqu7zTwZv5qU3gTofw3juLcXFKWpmewBhJkeQOx3ZSmJfCXo6TEZ+iPWxhnzaOuo9olOSaat2s24UBHUJN0moJQDEcWdBb3EMxZjFoVIW+h7raGHwes5FPGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f83rQFEOL1XE5VQ2B8LuBhVKh+ggyVxR+bTBDma1IQI=;
 b=B8LFJR3GtlKcU1uwP29P8L8ZbuR3tPEhFNdnmksnlZvlloAqqK60UmqiO4iGuJii0em1leJsa4hhfVMNgVXiES6UunYK7JVk9VJ7HDZGUJmLKchHfbjzKb7XKitWjUAf67YbWxT1SyBYgRvF0PPxALTE0qAX1WnHT1DLfLySVimkzDNyZL98e5HZ4ArBbDkJ0b67QIylVE2l12CxqLEoNP95iniOXNsbq81+jmG5c2K5furPtxvYoSi10eVYZmJS0FfGMVb8KIeTWGjc+uODRSNsNtr45V4lfBJKPokbyKqrZdNbTbVeeElopUL6JJ57gZRd+V5rfKYEbvjabNYHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f83rQFEOL1XE5VQ2B8LuBhVKh+ggyVxR+bTBDma1IQI=;
 b=nTDIUbL9laQyXGmv2ua74nyLZ2VNlmL0NFNMBuTZOdhE92G7pt66BUJBVuyqJI2uLgtz9Z/LTr3jFx8hW+pLgfnrb/qr6OUVymMwVuu8J+nI99G1KcbpxTjbAmelKHMbi+HP5TrlNmUbdIhi8wC8dOrGcYQhKPqBabofFPxJ15g=
Received: from DM4PR12MB5293.namprd12.prod.outlook.com (2603:10b6:5:390::24)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 21:17:32 +0000
Received: from DM4PR12MB5293.namprd12.prod.outlook.com
 ([fe80::59f9:2a42:8135:71a4]) by DM4PR12MB5293.namprd12.prod.outlook.com
 ([fe80::59f9:2a42:8135:71a4%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 21:17:31 +0000
From: "Liang, Richard qi" <Richardqi.Liang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Ying" <YING.LI@amd.com>
Subject: RE: [PATCH] drm/jpeg: add init value for num_jpeg_rings
Thread-Topic: [PATCH] drm/jpeg: add init value for num_jpeg_rings
Thread-Index: AQHZjn9BZkPTEhfwqEyLrNeF0g6ucq9p62Dw
Date: Wed, 24 May 2023 21:17:31 +0000
Message-ID: <DM4PR12MB5293FC019D7BCCD4B51E0BEAE1419@DM4PR12MB5293.namprd12.prod.outlook.com>
References: <20230524203504.3568374-1-James.Zhu@amd.com>
In-Reply-To: <20230524203504.3568374-1-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ef977c61-a089-4fa9-8efb-8b065f19586f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T21:10:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5293:EE_|IA1PR12MB6257:EE_
x-ms-office365-filtering-correlation-id: 2bd3a2f3-b2c5-4546-5681-08db5c9c495f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYSE2OaQlbfozRuxYIEesy34GDDB58iyHOnL/wJMrXzS9z14tShBtBXJzeyyxH9AB8h93l1TOWZ9CPgiE5FFburRQi9eckfGZVJAs7jAQWHPyZ0BgFLWgwGYYzh2g1aM3Lj2gXdE7IDWTpc1/bIvChdXRcjh0NZRiYMM2l3kL86j6Y4qKRHWxAqt75+PQp3wQ8wnE7Td+htaNtDhx2HRXBwuFpw9EiiMG35NVWbnHufDWHTy/ua3jF5mj4qKWpGh764O5NvrKjKMsjzsBTSTQYWwhXej/j4efxdvmjy65yAu09hjkTv5B3F77q6DLJlHGMHKW+DxLarb68j73xebD8FEq8U8d7zpK7P+cCy14bE2LyGFxWr5kNca1bAb1A4QRU+ShugRfBAn/V5qI/XVg61ARAjspAEj6WRjslXvad5erOpog71FLJtI6tfRlkVXWle01Mv019QsZbjvXRPAwe5pBdVuSW11ACcMPmroRldBPrqgvwsFHr2q1uGVhEpjAtxV9DCJr9yWFjfIq1CLCoShXtf7DIY35yRdF1eLpHYCj5dI/eN4dt7lX6tR0l83IpBMN3zO2mFBA9ByRnJDn53+zJgTgrBp+DdJhlNq2tyatmCNbctq+ir+dVVk2b4+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(26005)(6506007)(33656002)(9686003)(186003)(53546011)(122000001)(83380400001)(2906002)(38100700002)(41300700001)(110136005)(7696005)(71200400001)(316002)(54906003)(66446008)(66946007)(66556008)(66476007)(64756008)(76116006)(6636002)(4326008)(86362001)(38070700005)(55016003)(8936002)(52536014)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrfLLG4ne6xksDd58b3w9awxekm0J/aV/TnrV2mF35xUuE5QSrXn2Sx8CDYa?=
 =?us-ascii?Q?lKCF1y330b/utKx5/SnC2qiYbatRtiQy0KF1F22tY5ANQbwd1S2oN2LIpbGQ?=
 =?us-ascii?Q?xxGU8wdjmBQkL0715RA4lFUeg2X1lENrRzgUYAZxUxuTYDpbmoJMBNvkXA7D?=
 =?us-ascii?Q?WgowvqIASWREleTqcVXTscMqdqosJZU4Gp5SQot7uQJgKrdIfPN7NLDkn5nj?=
 =?us-ascii?Q?/9QQCvV1uu7DpWT8ebULBwm9JTPiheOUtWTh06DmNsCxG4o8YqBGyFXzT0MB?=
 =?us-ascii?Q?RNYn73bdHCrxXmWy+eNCbcGxXSfgLNfdZuaJa+sZBx8kg8Hm8RtLmahLzvOH?=
 =?us-ascii?Q?LbTt7xqSmKzXm3QkK/m4Sv4JGj/T0SK5au/6v3srXV8cPIFBTAIqFbZKnNUM?=
 =?us-ascii?Q?TaP/omVGcQCxlNuXSjmT42gOXIGyVY0973Cs8fGhHZdXi3aSG0iFDBKqSaNc?=
 =?us-ascii?Q?ZQUU0DPvlqvbtoBxKe49t7KVIygye1PWuyajrOwQ8EvAMS3G4NasauV/AUK8?=
 =?us-ascii?Q?Dki88iz14onnR7SaFXxmicmXo8Va+IVNyLH8g+KAuZrmac3x/7s7zjCVhT8/?=
 =?us-ascii?Q?PuVaMnYZggV2JyPF2pf884B83w/E08PYxuBTVLxzoAji3a+mHHragMWKenox?=
 =?us-ascii?Q?sfMIm/2s9sjxlEAUX9uznAUlUWQRyT/tbeyiO1iZnx6E1iE9kO2nij0StQxW?=
 =?us-ascii?Q?Ugukf0/OFgEJkLNJ+TC6SJ46Fxdpc+ZZPVA7P5JuqCu0PIiYMKh99qHItdBx?=
 =?us-ascii?Q?AE1I+siiHvNv+0EnSLVWr6dDEinROHyblJTydF96ljGj826BhU3JVFeruZ6H?=
 =?us-ascii?Q?OL5ccvp1Zyk7kiodwcN0xuZ/0OsDhUQgocFCPNQ5/F7Il52GfNJPSqp1DDT0?=
 =?us-ascii?Q?hWyR3BEeFES7B7kZas8r2gQydkPT6lFjV9j990OSl8DpcdDCAUmVHSjrQ7cz?=
 =?us-ascii?Q?1DOzOAiPgnp7vXUyq/EruKn5By1MqC3rWHrkTwZyW/a/iqiGEK473mK4uMbB?=
 =?us-ascii?Q?yYCIKwvXO2q33Zr66iQLR1Q36uZ9VcAc66iLnOuWVoKnsNHeXVOM7DCf+/9p?=
 =?us-ascii?Q?n4mVaCZhua/q3DWu2hry+Eb0V4quw11fhcKi/vPmJe5wYeAJUj+yyFtyoj54?=
 =?us-ascii?Q?u5IXcMa8pZkBiVMM+scCj6DMsb1buc9gFW+I0jEcUc/9zPhT1OsJuZKuM51/?=
 =?us-ascii?Q?6oMs0K4M+VdIG3T+/wzIp8H25I68BRau4qkwyOpIR5oL4nmusNC1J4RHx7Oc?=
 =?us-ascii?Q?ghGPHoQO+m5HMTVm/YBstBj0LgxtbK2JAYvrrtYDgcJNjnWDe0OYcsD8I8Sn?=
 =?us-ascii?Q?VCV2lK4LBkupdQEAezbqTV3jumAKYdps8rMWuYhMcpYoyWZH2Naf9O16qerO?=
 =?us-ascii?Q?SLlFotjTXuTrWkZv6QWJ9UNbm94hoMpM0mvLZ0WLDFsQRaJi6wPAIndTnKtt?=
 =?us-ascii?Q?UheVl+KyWTX2qHqZ5SvOmd4C4MVr3N+tayweh04Ny3yokKI9rRzCNfd1tJ8V?=
 =?us-ascii?Q?48vIx8JOZLen+vGbDTCbKB50zgOoN1AaeCZGdw+0md7UWdg5f71xZVqXJFzN?=
 =?us-ascii?Q?HGyKZSVzpJA2iEr1Zkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd3a2f3-b2c5-4546-5681-08db5c9c495f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 21:17:31.8306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lan1WEbIRWWmbXHooNlxKNEBCOst6dey6mco4560mWiftkq9vmQlX27Uc/NGvnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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
Cc: "Deng, Bonnie" <Bonnie.Deng@amd.com>, "Wu, Jason" <Jason.Wu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Richard Liang <rliang1@amd.com> for the patch.

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Wednesday, May 24, 2023 4:35 PM
To: amd-gfx@lists.freedesktop.org; Li, Ying <YING.LI@amd.com>
Cc: Wu, Jason <Jason.Wu2@amd.com>; Deng, Bonnie <Bonnie.Deng@amd.com>; Lian=
g, Richard qi <Richardqi.Liang@amd.com>
Subject: [PATCH] drm/jpeg: add init value for num_jpeg_rings

Need init new num_jpeg_rings to 1 on jpeg.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/j=
peg_v2_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +  drivers/gpu=
/drm/amd/amdgpu/jpeg_v3_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c |=
 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v1_0.c
index 1c5b60604a19..77595e9622da 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -460,6 +460,7 @@ int jpeg_v1_0_early_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v1_0_set_dec_ring_funcs(adev);
        jpeg_v1_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_0.c
index 3aeeceae34a5..c25d4a07350b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -49,6 +49,7 @@ static int jpeg_v2_0_early_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v2_0_set_dec_ring_funcs(adev);
        jpeg_v2_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c
index f533ede484d4..aadb74de52bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -60,6 +60,7 @@ static int jpeg_v2_5_early_init(void *handle)
        u32 harvest;
        int i;

+       adev->jpeg.num_jpeg_rings =3D 1;
        adev->jpeg.num_jpeg_inst =3D JPEG25_MAX_HW_INSTANCES_ARCTURUS;
        for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
                harvest =3D RREG32_SOC15(JPEG, i, mmCC_UVD_HARVESTING); dif=
f --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdg=
pu/jpeg_v3_0.c
index cb5494effc0f..79791379fc2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -64,6 +64,7 @@ static int jpeg_v3_0_early_init(void *handle)
        }

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v3_0_set_dec_ring_funcs(adev);
        jpeg_v3_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index 86383fbf9358..a707d407fbd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -58,6 +58,7 @@ static int jpeg_v4_0_early_init(void *handle)


        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v4_0_set_dec_ring_funcs(adev);
        jpeg_v4_0_set_irq_funcs(adev);
--
2.34.1

