Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4926C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 03:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1BF89F53;
	Thu, 25 Nov 2021 03:18:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FE389F53
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 03:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW95qTtQwekHpbamYZtkb4xQ3fPOgxX+XBfaC3CN7CdSJM2WijRYc5GXcFMb/2SCQI9b+++VKsDkyX8hvh7kEykZPUm/stamkJSkJWdFbWR+X/omPRPuYVZhOkOOsmADLmOhTpJcrSuatNQeeHgE1QIlKJlJNQwNLl4iL2cjWY0Ga3ICFhfbFds2utsFZehssT3Rikhuxs0h/0pRiltoyRN5KdT1R/MMVplvrik+SjweYC+SFc+NDQNExGxmF2M8veTP1RSNsvmVDB3uz5Zh9xmgm7ZEOosiSe65G78VJK+0NUXzHtKdKdgPYfcVgCl/tAp7uqvtS1HstMrYq22woA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CiqEC63nRall4GP86+ZTFBGtSgcBtzaZOQqgbbCXI4=;
 b=jYY13DuGhgLuoNE6x+vJFS5JV81R3aw40i+oT1x5+80AqLX3BkWblmsd2ti0ctK7Hhmg4VPIvTD/Z9jEOQDy3BDAZVP5wP0VulZfrwTksZFHieVUipQl9YWVlCgu4YMKrk0jmJJdNHYymrKHsMxCTWV4R+qBFxikHeI80IkId146xWNguBTTeACvlD/kE83hFDL5oYlzv2tjJRfAYTeDJpHK1+rbrMapoArr9s1EzrjMnt1Lt6H/SO8tQ/5ZBJMtoA3Qx3bP5J+6G6pnHLz5LxMypyJ7mOZQdJGQ9Ub4Nl3Zcq22hm4EiZ5Zw/AZQePMDb0SribrbEjkZ+7kiR6Xeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CiqEC63nRall4GP86+ZTFBGtSgcBtzaZOQqgbbCXI4=;
 b=cvsXE57hGFdJ7M1vqp0gL79QYk96UHJM4HuISJcByOsJ19UUCFesEYO+zKHswzGSn0h0Pa6DHnZs1aLDNIytvV5A2JKsb/yVidRtCEW7QPVu2xvTZdhvZB9vNzNWf6Gm4qhub+rSVxSTXBXrYtj8feXkqGE1Gxua7A90QZMm6D0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Thu, 25 Nov 2021 03:18:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 03:18:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4aqrOjTtszFS0kiPtvNWNuVlxawTkqCw
Date: Thu, 25 Nov 2021 03:18:31 +0000
Message-ID: <DM5PR12MB2469C901D0DDE2726871E788F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211125031447.5998-1-Jane.Jian@amd.com>
In-Reply-To: <20211125031447.5998-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T03:18:12Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4b428a65-14f5-4dc1-841c-643ca01f7c26;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-25T03:18:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0afbd9c5-0ba6-4fa1-8464-c8ca239d1377
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 545c62c4-c57a-4451-3d91-08d9afc241e1
x-ms-traffictypediagnostic: DM5PR12MB1868:
x-microsoft-antispam-prvs: <DM5PR12MB1868340EABC2E6634FD113EBF1629@DM5PR12MB1868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIbehkK7mmabQU50zejqL8xKSMABmuLeDgCThO9SDwMKSXJsrGAzISTkspDaUSK0bx5PsLpFoFtK0D/L6BLTun8CZO3EfgzoxbzUpy87bCA7l2gFFJXzHqP297V+kxRdJ3YMwraIDYENv1+YFiN28meera/GbaLRqoCKaqaoak0vg0Na6WzvPaqWBgp8cy8IzpBEOlC2tref0BCRqR/mAc4fKbK4+JsFd0qcH1489V2S7ARFmnMGT5NEYb93JxQxRLwWols2FD5b9OZWSFW/5X7gBpiFm9gjhqZREGuHDeRm5FA1G9H3AGouBxEl82ovqRsA+CFvcRGMLeY2sEGIHXl0a9yarsrrsYcFWbV3CJs8BP011XhwidlGM4na6RjlppK7lbaXs1rH2oV2K9GXeLXOurqS0NVdoQDfHxqzhefSd1qOtKarYSNqbjePmGQ6e/K8b1u3xPKdMpF7amFxCuvYmUUyr4b5xI3MM5QEQ58Q1mhGN38gUJesKV56/nbUwg1mY5W+fJ4SysxrZPOenPugz+4wim9VqsbSFxhfZA1oBXLiwgeHCYsLBtzH4vtxgJzALlsjws3bynnXQPhhcBnDnBeCGsnyGeTehpCE2HsUimPkIOrwTi+/KS9Rga9qqkb1f9R14ei7CKAyOiWrc51zwvZE+puOvo4PZC7dQS6kIPDd5Csv2f6YK/zOCm0W6gZ7v4gCNz0PX5lr7/ztEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(8936002)(53546011)(86362001)(122000001)(316002)(76116006)(83380400001)(33656002)(71200400001)(5660300002)(52536014)(55016003)(7696005)(9686003)(110136005)(54906003)(26005)(6636002)(38070700005)(66556008)(66446008)(64756008)(8676002)(508600001)(38100700002)(66946007)(4326008)(2906002)(66476007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/MVMvqThgiWGx1jkFFz7tejrzDAVNEEHpJIYjmWqUlLN+cWF1Lk3XHPgGRKP?=
 =?us-ascii?Q?XXV1xwGBUp/aUjclUZ9S0j3hBSXTegGuKoUEJVFky2lwwZe00x32zXFbuxxQ?=
 =?us-ascii?Q?VxbxZcWqucbUMl7zOUFbaKDfgMV36XcLQJRchkb4c03OcDEYmbBecE4kHR4A?=
 =?us-ascii?Q?28Ud/vigWRZtOOdTCwESNwY51PW1rSqggcWW9gRdCAXhaOXSPLyVsheZkO2R?=
 =?us-ascii?Q?KKKC/oYRmcZ0FmlMvvyhP3WtI0wGJQwiaS+TIIIxS2YRX4lsWKi7MvBLMmlZ?=
 =?us-ascii?Q?Y7L7qR8/tEtm3xhui9spTde9JidNnXbNUnEcShbHrRK9qSdvOm0h2HaJPHAB?=
 =?us-ascii?Q?IENhpdVvpiksnfD3mQK+sn5IhOsZYPE9iq7fw5pa24FgNVVtc01iH793RDpC?=
 =?us-ascii?Q?E+0m/ov4OS9KpVwfxXMrJoDwF3yQin0eUcW87ZwYh102I7+G7MpgO0m9DoIM?=
 =?us-ascii?Q?NXc8BAqSxNa8nYxdQ4YPB8JGqhO38ULTYlOQhE3vXpV56HLd6FCdahK2LqPI?=
 =?us-ascii?Q?RTWiJSuIsiy7IhJ/DT5HEGIfOlZYe7ZyvgqMAk6SmZosDB+aYl4vqAjyTK7K?=
 =?us-ascii?Q?V/vy15TPAKOchA6xKs2uQATVheaL72PVSvtRGFaIugX42flhll/7XMRNVNbB?=
 =?us-ascii?Q?YkkH21Q7JukH/vKKqlZOvPySWeEhwaiRmffdnqr0aGe0NqXfkuOTzWnCT665?=
 =?us-ascii?Q?SOoE6ojxFsNhMw6ucpyjDmH4ZK8N6vNnjIUuIj450cDfRXUbgDXx7zeQJIZm?=
 =?us-ascii?Q?SlvFusFCqSEdRcFML+uDRuopt993e6PQE/hz34+LOtRn6WOvOW7sWErccjGj?=
 =?us-ascii?Q?EVzwIDG1EgyQ6NnyIhzYeIf32PwOfl3bNqGkk/TufXm6dPB4ZVVPiP2ox+V6?=
 =?us-ascii?Q?+cdLE4XyHWiNvhuv80X/HWD6z2YigNeO0hwYj6BltIi8s1mJMawg2fYFQS4F?=
 =?us-ascii?Q?jFDg56ySEeorVqiux59EP2nbLwrPF1BFS3i9wWVoYYVstEjzh3wsT0c0JMqk?=
 =?us-ascii?Q?TraBoOArywkqe0JMvNO5wnvGiFbaOEMksT/rY0eoKXYjHCC4kauLT3aThnxP?=
 =?us-ascii?Q?X6I16lqqjm1/iOA6M7ye42y/OwzvrUmA0yqM2Fts16+DZARBjva8w9k0x4Zv?=
 =?us-ascii?Q?kY/Bj7iHTmNE7LI338NVMAJweDSLXRVHtMB35iZo7keSdO2i8QBK48NlNvM4?=
 =?us-ascii?Q?NW7u4Ku1eD7cJGV78ErK+nfyL7TjHSxdNE0Gd6ee4Vo5dvq0U7mMR6UAR8ET?=
 =?us-ascii?Q?4r/EBfstmyLXi8Z95sDqTqqc8nDiwjxXjHKeQW/8IANVgPom76uHVHl+gqEN?=
 =?us-ascii?Q?5rFlC/0H87erMpaTCMOpAA4ye8Rgl3HyRi/l/+8BGucrDXEN1XhnEjLpHif9?=
 =?us-ascii?Q?N+sVwBTrsaKHUZ9fbIsFcM4tRf8GFjY52nXZVSZ5jt91/cbAMLCaTMwFqaD2?=
 =?us-ascii?Q?IlzbduW0WhWxlcXZMMaIp+r+3uASRJ2MFcIiDimeGjfVJBGopCMVMHaBSgUo?=
 =?us-ascii?Q?KGWjW1EL8BCS5lQD9DZSMNnrad1taPiaTOQE91BC4ae7+p/lyWKdyao3xyPF?=
 =?us-ascii?Q?nBD5iPxOPJx3JisT9lHknTShMQb3t6o99TUzT4cBn5e5lp2A9MREy5E7/nMM?=
 =?us-ascii?Q?lMzxcB83HW8MTmxJI6YABn4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545c62c4-c57a-4451-3d91-08d9afc241e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 03:18:31.2942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIHRwgukt22fXS+X6ZU6H59xuJpRafKyqJU7SNMo+I0D3OArQCRmbuEzqEUmS5tZaZ5VSiJlHpf6jnDqxlQMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
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
Cc: "Jian, Jane" <Jane.Jian@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

I guess you need to add this IP version in nv_query_video_codecs as well.

With above clarified/fixed, this patch is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>=20
Sent: Thursday, November 25, 2021 11:15 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip in=
it for SIENNA_CICHLID

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature), which will be mismatched with original vcn0 revision

[HOW]
add new version check for vcn0 disabled revision(3, 0, 192), typically modi=
fied under sriov mode

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 503995c7ff6c..f6fae79203ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -918,6 +918,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amd=
gpu_device *adev)
 		case IP_VERSION(3, 0, 64):
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_v=
cn.c
index 4f7c70845785..585961c2f5f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
+	case IP_VERSION(3, 0, 192):
 		if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0))
 			fw_name =3D FIRMWARE_SIENNA_CICHLID;
 		else
--
2.17.1
