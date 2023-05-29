Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500F9C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 01:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9309010E136;
	Mon, 29 May 2023 01:50:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5310E136
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 01:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRrvlObEfhqyCV5gofh4dXdQ23GDiZ0CSoIKANHuFiijZdbMNtKCiaeeNibyvkb3/9MQ3w/KLER27CKve9O6JVoPKuJRXcOwgyaxmjAPbFAZxiOndN+Xq1lxC0Dl586f6ojfrtZKmVOauMepCtyC9gbvx/LdJwXuCxm6/BI+7XRwIIKSLE0HIT+LypaActoO5CO9nMAFFZ+V3iX2aYnxh5jr7+NlQ2fy4+QzxCZCPlQ63EyPeXq+fnipYY5PZU6IDFhD1CamhxMRZ1aZhnMTGhr4E/Ox71YISGYzXEBMHaXdhtA06oJAJjPKnjhZGZ7X9DLSVckXv7J9PhMUe37Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7MBpM8ZvFBmoyvU2fQgcDcoj343+Tw949Duwn9arvs=;
 b=gxHqa+c94uITYEYhJBKtCDaH4tuPkOyJwAI3acAuXt5f1VFj6I0gqauO9McVWEcjrYZSiCmF5YB/MC3pKaYZxenlEtec8LLbg0RfQDLlMSnYLK58OCya9QzZAllIbLybfZBoYqSSw4KoIldLQcrbDzXw+WrobPfy6mDkMqPDJYw0a7UvuCknOcDKTdIiHqFa70bnhtNq8qgVUvuvmx/aREPNCbmOp0/zXkG6DaCZDU3yHpvwYhqsf5ql7UMYwKcE8xCB9CfvX/3DkXIl17eKoVU/ArknJ/IfIKshQop1s4aPcD8qzOpvFSKWx5hDe3SG46kwTVXPv9jjnvo0nUjadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7MBpM8ZvFBmoyvU2fQgcDcoj343+Tw949Duwn9arvs=;
 b=WX+O2okS01Q7lR8UtLLI7N1zZfvNnEqvIpiSspCn9KA1kxm4mGHIEx9ng4glN9QcRafwikpOeFal1zXm493LCcj6F97Epon++1sXpnkv4Ggn2S/Y87XTK8uox8wns2cFJmXUTZUHO2sASWf5Qeoz55kxCctWG6ojzPNZ2M5yG4Y=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 01:50:35 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::d651:aad1:6b1:1194]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::d651:aad1:6b1:1194%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 01:50:35 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change reserved vram info print
Thread-Topic: [PATCH] drm/amdgpu: change reserved vram info print
Thread-Index: AQHZjuYQIROZCHajbE+Rp9cXmkReda9wggeg
Date: Mon, 29 May 2023 01:50:35 +0000
Message-ID: <CH2PR12MB42151AB4898632920E7A6822FC4A9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cb72976f-6483-4a72-bf9b-b74881e8c450;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-29T01:50:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DS7PR12MB8082:EE_
x-ms-office365-filtering-correlation-id: 41b5e172-46d9-418c-32bc-08db5fe71869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXjJxskssAuhyYgmK1Bj/W98KgTFfYUZDuVd6CYh/AGYOoZtejrGBA1wseEORzHr3NrrJDVUpDaG6bXPQil9y5H17vVIkxQxHF/GBR8ZdzyjqaO1jeTmjpB5oLNljZmm5J5nDLzLQN4pQ8SofGN9RT/MRhEpYIS1sRO1IgIXVh2fguhzZYN3wccK0Yi8L3iJC2GbS00xHm9NdrVuPIBNLcX8ydFmSsg9hrmJ960+eta8LgRM8ruOFeoQZlB1vxMfZPe3a7i7GQPv9yVSQ+YGbhqVVyggh+UcOgnxxTAAYSiOvumE218ULkY7CNWcuad7ygw+Q3PjD79UuVRgPkcv0r5JuQd4FkkOHsQZUoef1mWeAnkFC9QQJZkVoyYvaRgfZmSBWFSePKdIYbwqt6BPy34KlU3IxI6h57PzWO+vb9Z4V4dU5XbBMs+U294B+9nMWVTmOwwtgwiq6Hsfm6Pj+UZh+qAX95V/eVmtE9I0W/8GmBSleiOd4Pq07ob8UIgX925TIbCTT/z53sGe9/71w+HU3RiDDVUPZvKHP68eAPPQ3/3J+bHD/pM7ZbhtJUqIbVm4MBm1slQDL5JSvtU2xPAX5HO16UMFWCoLz0pBmqP+yEosWpqJ2GMixB0t0Kmm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(71200400001)(478600001)(54906003)(52536014)(5660300002)(8676002)(8936002)(38070700005)(2906002)(86362001)(33656002)(64756008)(66446008)(66556008)(66946007)(66476007)(4326008)(6916009)(76116006)(122000001)(316002)(55016003)(41300700001)(38100700002)(186003)(26005)(6506007)(9686003)(53546011)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kpf5ZRVPzLJsbYscP6zpFP+8nZcZsfltNbiq7mXcJB5iJlmaiXxG639QJIOR?=
 =?us-ascii?Q?91F/OBOFsM+4T0rvNa+Txqc/lGAls2DQgdLumdLoSh8U9QjiWwDLalpz5EwJ?=
 =?us-ascii?Q?BenCenAJYVHAYKYKR56wHem6Avb0RqNAxXzYmXjK5ZE6THltlqem1TvGxEy1?=
 =?us-ascii?Q?gxriF2BtU927uxY/grOVTDfBDSzJfg4wn+XZG4lJQHIfClkBq0cKCz1vuORe?=
 =?us-ascii?Q?BLTtRO9TFQv6zUZXrX3ncIPmD67QOhCKXGjSbrbshnt5/yHTkeYEDn301coG?=
 =?us-ascii?Q?cp6vIfNvXsk7gqRm1dnsW8SIzITdh+M9eCp+Sow6Y9nXGMakF1eTbpwBQ23Q?=
 =?us-ascii?Q?WIlTSJaZ2YVqWqV/ZlxtNgmqhd7k+rLZuLF0Aymt0wpzg1hNctmu8nMkvrxk?=
 =?us-ascii?Q?0VjDTxXyFNYh1grlPyzeKifPp5Hy9lC80po3BORV95scx0p4balRRycf0+FM?=
 =?us-ascii?Q?Oa6RKxHY2gCwFRK6dj13mMm3Ce10nF9GZgG0I0W7KX6iftKfo29Qba9B8GbY?=
 =?us-ascii?Q?0FbQM0DZ9VYmOG+A7ElJauWUvkdtV04fKJua6Uz2Rl6668RQlWNCWAO/O0E9?=
 =?us-ascii?Q?z7qQ/0doWDtq9BHfzzHX0+g0KiHx4HPYxxlmNu5uzOxL8B2dMizn1jzMHFuj?=
 =?us-ascii?Q?Bx6WPbFE6bw7E7o3mPJxEuyckQOjTNkcKCExLZFMdg7FS1uJCSewKJqbSYSt?=
 =?us-ascii?Q?WrjG+HV4rJnCfLyYflh8Cdi2wKR1XnC6BDfezRXeHmajFk5S4urFBlcndNJe?=
 =?us-ascii?Q?LW+VfUO01g9mBSxLqONjoMRyUS/3tNc8ZaWmdz5qz1ZWV71GuBN7RtXC1mPX?=
 =?us-ascii?Q?D/vU543wVU2Jd8ifN1eym6u5aPD8FoZrdC+cY7JaB8s7USVJsUWt3zybc++d?=
 =?us-ascii?Q?hc0LapMhg78I3tBQjz0h3fJ48ZCudcCgoSWEO36Ehj9pLt4BkCw6p7mhtcfE?=
 =?us-ascii?Q?bjUmSlfoGY10HuaUvUubvGk+hnnQJ2Hod2+KubRKw8WxlU88lLMkTxHZrosY?=
 =?us-ascii?Q?gi4iR5GQEUnxMUXAGQopnI+oPjoU7FOqzywQMYqXDM5nT3PCjAJ+Sf5wWINL?=
 =?us-ascii?Q?5zEJ7zlAxQpPWkSsoeOaaiWCzGAJQ+xLTeQHH9saHa1w1dHzBvq57lS0Ci+c?=
 =?us-ascii?Q?OTBKvIju14gZZzd17UFTX33VJpInkxHBOCnBEeAuZlt1Qf+vV82bGe9ThnO7?=
 =?us-ascii?Q?g+9zgGN6pP5axh5Qwa63mgc5DimEtdIhuRrDaMAJNjj579fBfVy49mpYOB2j?=
 =?us-ascii?Q?BJKbE290YY36pc37SZdeQQb0DnxJ/9KFx6x8PaqO9X+548pT+Zb4w0sLxffb?=
 =?us-ascii?Q?mKIiXmZ8hiE0o3U3FjMo4jvOBxsN1WabeGR0GfGemrsHFbAx6kP0Onv7xYYQ?=
 =?us-ascii?Q?0WS5xTjpnKEgZHqUv94hPtwNnv6ouT+/C/KLabAQgsBxztoQf3PH1KizjY7o?=
 =?us-ascii?Q?OfJye2QGwTwAS4BnrKNTIP6PzAE7vVlZKq9ytgrC8arOYW04pWaYihPZk9Om?=
 =?us-ascii?Q?dbrqpjiMcj/QTnh0TzfyCWoyGWPgvwhXEHJFVHrg4dd9Qsoslkd3Vjbg7n1a?=
 =?us-ascii?Q?2X1mZ4I0mzml2iwJHGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b5e172-46d9-418c-32bc-08db5fe71869
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 01:50:35.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRjYTWWtUoUypTMGl6wq7YDot/hkYXmIQzlwOrE1ea7WOVP7j5KLcAbzLsZmV2QtRQ3XXvkFLGbS1DZkVfsBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping ....


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, May 25, 2023 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: change reserved vram info print

The link object of mgr->reserved_pages is the blocks variable in struct amd=
gpu_vram_reservation, not the link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index 89d35d194f2c..c7085a747b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_m=
anager *man,  {
        struct amdgpu_vram_mgr *mgr =3D to_vram_mgr(man);
        struct drm_buddy *mm =3D &mgr->mm;
-       struct drm_buddy_block *block;
+       struct amdgpu_vram_reservation *rsv;

        drm_printf(printer, "  vis usage:%llu\n",
                   amdgpu_vram_mgr_vis_usage(mgr));
@@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_m=
anager *man,
        drm_buddy_print(mm, printer);

        drm_printf(printer, "reserved:\n");
-       list_for_each_entry(block, &mgr->reserved_pages, link)
-               drm_buddy_block_print(mm, block, printer);
+       list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
+               drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+                       rsv->start, rsv->start + rsv->size, rsv->size);
        mutex_unlock(&mgr->lock);
 }

--
2.34.1

