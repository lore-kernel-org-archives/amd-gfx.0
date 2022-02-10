Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D554BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 03:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B35210E31D;
	Thu, 10 Feb 2022 03:43:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9815910E31D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 03:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKZedIvvqhevSufZMLESSTuYBPL3ElTMYMSdFa+/qfMhasc/RPWyapx3Uzr99UqdORcldhYkzfObLJ8Tc1oEDSVpbfVufSi7E4ilt0OdDPR59+7z4kMj5I/n5i/CdtuACEvZdJ+/sA2F+6n8bOMKvXRIszWx4fpvNWz2Q27EZzEYn9mFqyD7Ap+cDbgrPGc1su3/mohj1wYPQXRSEPD/aOEo3+C611yfBNIpuNMj1pxoFl0Rhs0GSLJPJYmwLfLwYN0KYy+q36wG5zR/l6LHHLWF//ffXfsLRn3QwMTdOUxa+R2jbMLG76cSK4zxjEm2tTgbmgc9PnIf8ye6r4tHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28RIBYjTOFf+lWN3OX7GlxIefh1vIqdVhobMcNfN2Os=;
 b=KS+eoNuVEUFfQ3DTW+c7v2bACjl6KQERsKtz2TlcDw5zv/cJPfeKg3tK6j73vBPhnPkPROxI3tLj8bFN+V8WP+sFdgC2xWQpdaX1xrQpVbIEmIrLPgQX8f4AvF4V9tkVO0r4R4twLZL5HSU/Laviq9vpJTwmwLyghiUmzWLve3R7W/VcLtr/Lw68nGoS91Yqgq2Pd8tAZcVJWocIdNFnyJXjYLZgogB77VDlNxNps7OFErtYmXcuW8xx8cYMzOLsStvEuYix76HujHcH/wBcO3j92f8I2ANKKuHhBKaX6Y3bctNb9euvxUTz6UetpixMuubPzf8mrQxoODHZvHAKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28RIBYjTOFf+lWN3OX7GlxIefh1vIqdVhobMcNfN2Os=;
 b=0b3q+WDfQXWQcEdgJY26jjZdKbjy5SAx8xCx1az91FZ/g4YKWinvxf9SE8ywGvcft6pUhq5bpFkqErbOvpfJ+9G6q/prVNe+PpGgAVcplNIGR7HdIj/J3R9x7luFLgVPYMMi7etqMyfxijNiDVjYXXB3cIQXjC12bcrCqNk1ous=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CY4PR1201MB0248.namprd12.prod.outlook.com (2603:10b6:910:18::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 03:43:38 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b00a:76d1:7eb7:ec63]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b00a:76d1:7eb7:ec63%3]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:43:38 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1 1/1] drm/amdgpu: Show IP discovery in sysfs
Thread-Topic: [PATCH v1 1/1] drm/amdgpu: Show IP discovery in sysfs
Thread-Index: AQHYHgetQFmJmieu90+lo4tvA4KLBKyMIddc
Date: Thu, 10 Feb 2022 03:43:38 +0000
Message-ID: <CO6PR12MB5473C3CF13FE77DC10914F60822F9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220209225144.8433-1-luben.tuikov@amd.com>
 <20220209225144.8433-2-luben.tuikov@amd.com>
In-Reply-To: <20220209225144.8433-2-luben.tuikov@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T03:43:36.703Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13e132d3-5f17-42f1-d408-08d9ec4785f8
x-ms-traffictypediagnostic: CY4PR1201MB0248:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB02484769C7C5B009319ACD27822F9@CY4PR1201MB0248.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:113;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEgejzmE2q1gVyYUximwewTiU4twxapP08TVNw97MzZELWmIItfQ3ICIz/Lusi0ZX3IVPXxwOcRxx7r26iIZZPtbIV1wvPalUd5h0gVMDV4m2xaAFBv7hygCn5jbraDpYJQHZThFEewueM2lWmFl0wkhTlwxXdfymO09Q4Kqg9JcIpR/vym8jp1FXyAMznX8mlJW7VBBN38rXAWeIeenBFzP/CMMtlvD4Logm8MOQ8QhoQKjAq5hFtM/L4Rrpg8008XjdJKkCnSmZPemiTaCmauvTcV+5+W/w7Ja7MRkbfOEvsFHivl04qt4lvcHzK6Wfzl6yWM18RT7j0BQbbNpdp8Mhk/U/alAF7PkcOXHO/swVVlA8JCLqOvxPdjz4V0ZvnbWVvxHF/D6EGn84IhkwUy1J0CX3cUYpqz0nwJ10L1KIWK2XYZf6TdXAxbpSFlLiXI3gXwQ3cy943qP2q6Lzoh4YoqIDiZRHOR6BqjXYgdB3Ym8Y9hu8bskbM9ummen0Gr8DI/q/yExpvDhyLLcds6YJ+8AJT9YM70Utk5udft2g8iFe0uvvQ2ZLhghKcauuKo3tTyun7x3FOvKZ9tZOkG2fX8xDa5zavOlFs/VED8zq2wh2edGu091+7RiNRw5ajSulnEmhAtbc8YqiUOHTZeAF+ArJcJYsNd5a208+JCoKbOkmTVWUIFsGYprrnVIxDEzasslbsX6x+UOgPDhZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(186003)(33656002)(38100700002)(91956017)(86362001)(316002)(26005)(5660300002)(110136005)(54906003)(6506007)(83380400001)(9686003)(2906002)(19627405001)(66556008)(52536014)(8936002)(66946007)(4326008)(122000001)(30864003)(66446008)(8676002)(64756008)(66476007)(53546011)(508600001)(7696005)(76116006)(38070700005)(71200400001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BrPE3ESs8Yee42mqD6Oi0ktTRh2c61f/086l8pRnF0aX2x3XBE9ROGE6tH?=
 =?iso-8859-1?Q?zACZ8G348EqRL2wjuKrNvIv57WRFG4DmJ77inzQ/xjliK4br0EFl256nEs?=
 =?iso-8859-1?Q?3QR3Iexub6duOYclNx+R2GilX+y/zIhPHiPasaRvdhrCwRp/zN91KtOp0x?=
 =?iso-8859-1?Q?DphalXR8ADnTZJhCy07aSy29/PKuhyFzUxq13i+CJfhFjckxyDJ6NNnX2k?=
 =?iso-8859-1?Q?aSHuZRulY7B91HFT4U9D/z0PrNjdm4jGnJkjIlzl+hGJof/NcjVAlprg/c?=
 =?iso-8859-1?Q?00YY3sDmFosISSGCdbPIwB95Bue/mIS0eAn/SkydPlB2oj525OV1xBFO+a?=
 =?iso-8859-1?Q?gJo0FUB3WZ4RBKXHLblNL0uQrN0ogT9KfyZusiDEab3uZ2zArt54AVrDq7?=
 =?iso-8859-1?Q?vUSNfD42FitUwcm/VNpqKmjiSZXpwkDlbahjPop3DgFX/9e2LMxOVtME0t?=
 =?iso-8859-1?Q?SuJDCRHTSwOaLFMRTevnLM7AqmXdvF/jnDOQzMyc6QnUUkYIzRQn9LFfqM?=
 =?iso-8859-1?Q?sO61rpstNhnlGpwinIyT30RKqxr1TyJ35DTvm26hfO0wBvXYOsgh0wvAWi?=
 =?iso-8859-1?Q?THqdXBF/8bn6uwwuKdo1Sa8SkPpOuapMWhmL4T8Gc6jyaOd34xK3UtXi30?=
 =?iso-8859-1?Q?pkRkuqDxo94pjQxJLcWBsW/Qz2UDbeBMLb2EBNOwabX7LOpAravkuYozj4?=
 =?iso-8859-1?Q?RG+fsvtdbRWXhVLSNXMY3lodRbG/qLVTPTnw2mJvBeROzBxXkL12SQR599?=
 =?iso-8859-1?Q?PQk3XYazit0Nfrjupkw8PHtnmHeiDDNn5h9AMtTlGoHcPXnw7ORA5GOLJP?=
 =?iso-8859-1?Q?18R0LL5CIDKpLOBdQ8bhG2x7F1SH1fIDwnuCz+Dr5MfZT7tvGJkP22TjQu?=
 =?iso-8859-1?Q?eS5i47REU1FoNgeSazXLobLe0t5OuUyA2S0Q9ie78SxeSydF0pTR9qj1OM?=
 =?iso-8859-1?Q?t5e3o3KDOmW/GJr/gdhun0rQHJHDBMbzCrrjAQQvw5bwyAG1CFpi1XljL3?=
 =?iso-8859-1?Q?XnJbuAj21WOCdK0ZbLTuJSBWSQEUMarHIkad+jhfPjuxAMuR/55sAjkOiO?=
 =?iso-8859-1?Q?7d6Yk43S/+HaHQrAE6M/DE4LqLhayMMyKfUxOLA0yTxaw3AXpyvVSUEDKG?=
 =?iso-8859-1?Q?EQNqdpwdZVDxw0fJzHAcqcnZEdAKYrnBvyG9JLj6yld8F2GarjZAisqlb1?=
 =?iso-8859-1?Q?HT54rBn8rf0rskLjZTvsN+EARKwcvJBKRkhW2icBvE1f1IcaTNHoVLJ573?=
 =?iso-8859-1?Q?0++l9LgJebOcdLkDMYy1sRHQ72QbGaoT9afP5pgELGIq2G+8FqO4n9BPi1?=
 =?iso-8859-1?Q?RhE9UtSPBRYGNvzBhXu1FL47sQ+WaeyhaDHCrXHbpw94r4bnOjUfdZPaGN?=
 =?iso-8859-1?Q?apS6LH2ytXu8MCrG6RCV16fIJGZ+SaaN/5D3UZyn+Y45OvypQ0EzKMiOJ2?=
 =?iso-8859-1?Q?m6wN0OQl9qFm6aVs01HA5D7agSNdic6YhH5AvGw7ztC5hUo8ZL3Rc0/cRz?=
 =?iso-8859-1?Q?M5Aom8Yrk4XXB/y2cX52bcBJRZt/BLgPTVrc1tayKO+lRGeAiqGL4K/DA+?=
 =?iso-8859-1?Q?oHvKC/DwOaMSLWVN3SMFFIH2N/S/uX0nez94hxVcEdZBh/NoM7iOZww32t?=
 =?iso-8859-1?Q?7BbQg0FvsXLQU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473C3CF13FE77DC10914F60822F9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e132d3-5f17-42f1-d408-08d9ec4785f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:43:38.2896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZd49ffrFkLFx4YfiXzCBtyMIVlPtJr2ZvGcWnxR6CmzL/J8ZuuevxZU4zxOKbGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0248
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473C3CF13FE77DC10914F60822F9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Luben Tu=
ikov <luben.tuikov@amd.com>
Sent: Thursday, February 10, 2022 6:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>
Subject: [PATCH v1 1/1] drm/amdgpu: Show IP discovery in sysfs

Add IP discovery data in sysfs. The format is:
/sys/class/drm/cardX/device/ip_discovery/die/D/B/I/<attrs>
where,
X is the card ID, an integer,
D is the die ID, an integer,
B is the IP HW ID, an integer, aka block type,
I is the IP HW ID instance, an integer.
<attrs> are the attributes of the block instance. At the moment these
include HW ID, instance number, major, minor, revision, number of base
addresses, and the base addresses themselves.

A symbolic link of the acronym HW ID is also created, under D/, if you
prefer to browse by something humanly accessible.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 486 ++++++++++++++++++
 2 files changed, 490 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index e4eb812ade2fa4..3a126dce8a2fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -772,6 +772,8 @@ struct amd_powerplay {
         const struct amd_pm_funcs *pp_funcs;
 };

+struct ip_discovery_top;
+
 /* polaris10 kickers */
 #define ASICID_IS_P20(did, rid)         (((did =3D=3D 0x67DF) && \
                                          ((rid =3D=3D 0xE3) || \
@@ -1097,6 +1099,8 @@ struct amdgpu_device {
         bool                            ram_is_direct_mapped;

         struct list_head                ras_list;
+
+       struct ip_discovery_top         *ip_top;
 };

 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 07623634fdc2f1..46e6e1352574f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -360,8 +360,11 @@ static int amdgpu_discovery_init(struct amdgpu_device =
*adev)
         return r;
 }

+static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
+
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
+       amdgpu_discovery_sysfs_fini(adev);
         kfree(adev->mman.discovery_bin);
         adev->mman.discovery_bin =3D NULL;
 }
@@ -382,6 +385,487 @@ static int amdgpu_discovery_validate_ip(const struct =
ip *ip)
         return 0;
 }

+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
+
+struct ip_hw_instance {
+       struct kobject kobj; /* ip_discovery/die/#die/#hw_id/#instance/<att=
rs...> */
+
+       int hw_id;
+       u8  num_instance;
+       u8  major, minor, revision;
+
+       int num_base_addresses;
+       u32 base_addr[0];
+};

[kevin]:

  1.  use flex-array instead of zero length array is better to match kernel=
 coding style and avoid some compiler warning. eg: "u32 base_addr[];"
  2.  please use following macro helper to handle array size.
// include/linux/overflow.h
- struct_size() - Calculate size of structure with trailing array.
  3.  - flex_array_size() - Calculate size of a flexible array member withi=
n an enclosing structure.

On the other hand, do we really need variable length arrays?  why not fix s=
ize to 4?
+
+struct ip_hw_id {
+       struct kset hw_id_kset;  /* ip_discovery/die/#die/#hw_id/, contains=
 ip_hw_instance */
+       int hw_id;
+};
+
+struct ip_die_entry {
+       struct kset ip_kset;     /* ip_discovery/die/#die/, contains ip_hw_=
id  */
+       u16 num_ips;
+};
+
+/* -------------------------------------------------- */
+
+struct ip_hw_instance_attr {
+       struct attribute attr;
+       ssize_t (*show)(struct ip_hw_instance *ip_hw_instance, char *buf);
+};
+
+static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->hw_id);
+}
+
+static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, ch=
ar *buf)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->num_instance);
+}
+
+static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->major);
+}
+
+static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->minor);
+}
+
+static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *=
buf)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->revision);
+}
+
+static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instan=
ce, char *buf)
+{
+       return sprintf(buf, "%d\n", ip_hw_instance->num_base_addresses);
+}
+
+static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char =
*buf)
+{
+       ssize_t res =3D 0;
+       int ii;
+
+       for (ii =3D 0; ii < ip_hw_instance->num_base_addresses; ii++) {
+               if (res + 12 >=3D PAGE_SIZE)
+                       break;
+               res +=3D sprintf(buf + res, "0x%08X\n", ip_hw_instance->bas=
e_addr[ii]);
+       }
+
+       return res;
+}
+
+static struct ip_hw_instance_attr ip_hw_attr[] =3D {
+       __ATTR_RO(hw_id),
+       __ATTR_RO(num_instance),
+       __ATTR_RO(major),
+       __ATTR_RO(minor),
+       __ATTR_RO(revision),
+       __ATTR_RO(num_base_addresses),
+       __ATTR_RO(base_addr),
+};
+
+static struct attribute *ip_hw_instance_attrs[] =3D {
+       &ip_hw_attr[0].attr,
+       &ip_hw_attr[1].attr,
+       &ip_hw_attr[2].attr,
+       &ip_hw_attr[3].attr,
+       &ip_hw_attr[4].attr,
+       &ip_hw_attr[5].attr,
+       &ip_hw_attr[6].attr,
+       NULL,
+};
+ATTRIBUTE_GROUPS(ip_hw_instance);
+
+#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
+#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_at=
tr, attr)
+
+static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,
+                                       struct attribute *attr,
+                                       char *buf)
+{
+       struct ip_hw_instance *ip_hw_instance =3D to_ip_hw_instance(kobj);
+       struct ip_hw_instance_attr *ip_hw_attr =3D to_ip_hw_instance_attr(a=
ttr);
+
+       if (!ip_hw_attr->show)
+               return -EIO;
+
+       return ip_hw_attr->show(ip_hw_instance, buf);
+}
+
+static const struct sysfs_ops ip_hw_instance_sysfs_ops =3D {
+       .show =3D ip_hw_instance_attr_show,
+};
+
+static void ip_hw_instance_release(struct kobject *kobj)
+{
+       struct ip_hw_instance *ip_hw_instance =3D to_ip_hw_instance(kobj);
+
+       kfree(ip_hw_instance);
+}
+
+static struct kobj_type ip_hw_instance_ktype =3D {
+       .release =3D ip_hw_instance_release,
+       .sysfs_ops =3D &ip_hw_instance_sysfs_ops,
+       .default_groups =3D ip_hw_instance_groups,
+};
+
+/* -------------------------------------------------- */
+
+#define to_ip_hw_id(x)  container_of(to_kset(x), struct ip_hw_id, hw_id_ks=
et)
+
+static void ip_hw_id_release(struct kobject *kobj)
+{
+       struct ip_hw_id *ip_hw_id =3D to_ip_hw_id(kobj);
+
+       if (!list_empty(&ip_hw_id->hw_id_kset.list))
+               DRM_ERROR("ip_hw_id->hw_id_kset is not empty");
+       kfree(ip_hw_id);
+}
+
+static struct kobj_type ip_hw_id_ktype =3D {
+       .release =3D ip_hw_id_release,
+       .sysfs_ops =3D &kobj_sysfs_ops,
+};
+
+/* -------------------------------------------------- */
+
+static void die_kobj_release(struct kobject *kobj);
+static void ip_disc_release(struct kobject *kobj);
+
+struct ip_die_entry_attribute {
+       struct attribute attr;
+       ssize_t (*show)(struct ip_die_entry *ip_die_entry, char *buf);
+};
+
+#define to_ip_die_entry_attr(x)  container_of(x, struct ip_die_entry_attri=
bute, attr)
+
+static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)
+{
+       return sprintf(buf, "%d\n", ip_die_entry->num_ips);
+}
+
+/* If there are more ip_die_entry attrs, other than the number of IPs,
+ * we can make this intro an array of attrs, and then initialize
+ * ip_die_entry_attrs in a loop.
+ */
+static struct ip_die_entry_attribute num_ips_attr =3D
+       __ATTR_RO(num_ips);
+
+static struct attribute *ip_die_entry_attrs[] =3D {
+       &num_ips_attr.attr,
+       NULL,
+};
+ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */
+
+#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, i=
p_kset)
+
+static ssize_t ip_die_entry_attr_show(struct kobject *kobj,
+                                     struct attribute *attr,
+                                     char *buf)
+{
+       struct ip_die_entry_attribute *ip_die_entry_attr =3D to_ip_die_entr=
y_attr(attr);
+       struct ip_die_entry *ip_die_entry =3D to_ip_die_entry(kobj);
+
+       if (!ip_die_entry_attr->show)
+               return -EIO;
+
+       return ip_die_entry_attr->show(ip_die_entry, buf);
+}
+
+static void ip_die_entry_release(struct kobject *kobj)
+{
+       struct ip_die_entry *ip_die_entry =3D to_ip_die_entry(kobj);
+
+       if (!list_empty(&ip_die_entry->ip_kset.list))
+               DRM_ERROR("ip_die_entry->ip_kset is not empty");
+       kfree(ip_die_entry);
+}
+
+static const struct sysfs_ops ip_die_entry_sysfs_ops =3D {
+       .show =3D ip_die_entry_attr_show,
+};
+
+static struct kobj_type ip_die_entry_ktype =3D {
+       .release =3D ip_die_entry_release,
+       .sysfs_ops =3D &ip_die_entry_sysfs_ops,
+       .default_groups =3D ip_die_entry_groups,
+};
+
+static struct kobj_type die_kobj_ktype =3D {
+       .release =3D die_kobj_release,
+       .sysfs_ops =3D &kobj_sysfs_ops,
+};
+
+static struct kobj_type ip_discovery_ktype =3D {
+       .release =3D ip_disc_release,
+       .sysfs_ops =3D &kobj_sysfs_ops,
+};
+
+struct ip_discovery_top {
+       struct kobject kobj;    /* ip_discovery/ */
+       struct kset die_kset;   /* ip_discovery/die/, contains ip_die_entry=
 */
+       struct amdgpu_device *adev;
+};
+
+static void die_kobj_release(struct kobject *kobj)
+{
+       struct ip_discovery_top *ip_top =3D container_of(to_kset(kobj),
+                                                      struct ip_discovery_=
top,
+                                                      die_kset);
+       if (!list_empty(&ip_top->die_kset.list))
+               DRM_ERROR("ip_top->die_kset is not empty");
+}
+
+static void ip_disc_release(struct kobject *kobj)
+{
+       struct ip_discovery_top *ip_top =3D container_of(kobj, struct ip_di=
scovery_top,
+                                                      kobj);
+       struct amdgpu_device *adev =3D ip_top->adev;
+
+       adev->ip_top =3D NULL;
+       kfree(ip_top);
+}
+
+static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
+                                     struct ip_die_entry *ip_die_entry,
+                                     const size_t _ip_offset, const int nu=
m_ips)
+{
+       int ii, jj, kk, res;
+
+       DRM_DEBUG("num_ips:%d", num_ips);
+
+       /* Find all IPs of a given HW ID, and add their instance to
+        * #die/#hw_id/#instance/<attributes>
+        */
+       for (ii =3D 0; ii < HW_ID_MAX; ii++) {
+               struct ip_hw_id *ip_hw_id =3D NULL;
+               size_t ip_offset =3D _ip_offset;
+
+               for (jj =3D 0; jj < num_ips; jj++) {
+                       struct ip *ip;
+                       struct ip_hw_instance *ip_hw_instance;
+
+                       ip =3D (struct ip *)(adev->mman.discovery_bin + ip_=
offset);
+                       if (amdgpu_discovery_validate_ip(ip) ||
+                           le16_to_cpu(ip->hw_id) !=3D ii)
+                               goto next_ip;
+
+                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset=
);
+
+                       /* We have a hw_id match; register the hw
+                        * block if not yet registered.
+                        */
+                       if (!ip_hw_id) {
+                               ip_hw_id =3D kzalloc(sizeof(*ip_hw_id), GFP=
_KERNEL);
+                               if (!ip_hw_id)
+                                       return -ENOMEM;
+                               ip_hw_id->hw_id =3D ii;
+
+                               kobject_set_name(&ip_hw_id->hw_id_kset.kobj=
, "%d", ii);
+                               ip_hw_id->hw_id_kset.kobj.kset =3D &ip_die_=
entry->ip_kset;
+                               ip_hw_id->hw_id_kset.kobj.ktype =3D &ip_hw_=
id_ktype;
+                               res =3D kset_register(&ip_hw_id->hw_id_kset=
);
+                               if (res) {
+                                       DRM_ERROR("Couldn't register ip_hw_=
id kset");
+                                       kfree(ip_hw_id);
+                                       return res;
+                               }
+                               if (hw_id_names[ii]) {
+                                       res =3D sysfs_create_link(&ip_die_e=
ntry->ip_kset.kobj,
+                                                               &ip_hw_id->=
hw_id_kset.kobj,
+                                                               hw_id_names=
[ii]);
+                                       if (res) {
+                                               DRM_ERROR("Couldn't create =
IP link %s in IP Die:%s\n",
+                                                         hw_id_names[ii],
+                                                         kobject_name(&ip_=
die_entry->ip_kset.kobj));
+                                       }
+                               }
+                       }
+
+                       /* Now register its instance.
+                        */
+                       ip_hw_instance =3D kzalloc(sizeof(*ip_hw_instance) =
+
+                                                sizeof(u32) * ip->num_base=
_address,
+                                                GFP_KERNEL);
+                       if (!ip_hw_instance) {
+                               DRM_ERROR("no memory for ip_hw_instance");
+                               return -ENOMEM;
+                       }
+                       ip_hw_instance->hw_id =3D le16_to_cpu(ip->hw_id); /=
* =3D=3D ii */
+                       ip_hw_instance->num_instance =3D ip->number_instanc=
e;
+                       ip_hw_instance->major =3D ip->major;
+                       ip_hw_instance->minor =3D ip->minor;
+                       ip_hw_instance->revision =3D ip->revision;
+                       ip_hw_instance->num_base_addresses =3D ip->num_base=
_address;
+
+                       for (kk =3D 0; kk < ip_hw_instance->num_base_addres=
ses; kk++)
+                               ip_hw_instance->base_addr[kk] =3D ip->base_=
address[kk];
+
+                       kobject_init(&ip_hw_instance->kobj, &ip_hw_instance=
_ktype);
+                       ip_hw_instance->kobj.kset =3D &ip_hw_id->hw_id_kset=
;
+                       res =3D kobject_add(&ip_hw_instance->kobj, NULL,
+                                         "%d", ip_hw_instance->num_instanc=
e);
+next_ip:
+                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+               }
+       }
+
+       return 0;
+}
+
+static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
+{
+       struct binary_header *bhdr;
+       struct ip_discovery_header *ihdr;
+       struct die_header *dhdr;
+       struct kset *die_kset =3D &adev->ip_top->die_kset;
+       u16 num_dies, die_offset, num_ips;
+       size_t ip_offset;
+       int ii, res;
+
+       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
+       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin +
+                                             le16_to_cpu(bhdr->table_list[=
IP_DISCOVERY].offset));
+       num_dies =3D le16_to_cpu(ihdr->num_dies);
+
+       DRM_DEBUG("number of dies: %d\n", num_dies);
+
+       for (ii =3D 0; ii < num_dies; ii++) {
+               struct ip_die_entry *ip_die_entry;
+
+               die_offset =3D le16_to_cpu(ihdr->die_info[ii].die_offset);
+               dhdr =3D (struct die_header *)(adev->mman.discovery_bin + d=
ie_offset);
+               num_ips =3D le16_to_cpu(dhdr->num_ips);
+               ip_offset =3D die_offset + sizeof(*dhdr);
+
+               /* Add the die to the kset.
+                *
+                * dhdr->die_id =3D=3D ii, which was checked in
+                * amdgpu_discovery_reg_base_init().
+                */
+
+               ip_die_entry =3D kzalloc(sizeof(*ip_die_entry), GFP_KERNEL)=
;
+               if (!ip_die_entry)
+                       return -ENOMEM;
+
+               ip_die_entry->num_ips =3D num_ips;
+
+               kobject_set_name(&ip_die_entry->ip_kset.kobj, "%d", le16_to=
_cpu(dhdr->die_id));
+               ip_die_entry->ip_kset.kobj.kset =3D die_kset;
+               ip_die_entry->ip_kset.kobj.ktype =3D &ip_die_entry_ktype;
+               res =3D kset_register(&ip_die_entry->ip_kset);
+               if (res) {
+                       DRM_ERROR("Couldn't register ip_die_entry kset");
+                       kfree(ip_die_entry);
+                       return res;
+               }
+
+               amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, n=
um_ips);
+       }
+
+       return 0;
+}
+
+static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
+{
+       struct kset *die_kset;
+       int res;
+
+       adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
+       if (!adev->ip_top)
+               return -ENOMEM;
+
+       adev->ip_top->adev =3D adev;
+
+       res =3D kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_kty=
pe,
+                                  &adev->dev->kobj, "ip_discovery");
+       if (res) {
+               DRM_ERROR("Couldn't init and add ip_discovery/");
+               goto Err;
+       }
+
+       die_kset =3D &adev->ip_top->die_kset;
+       kobject_set_name(&die_kset->kobj, "%s", "die");
+       die_kset->kobj.parent =3D &adev->ip_top->kobj;
+       die_kset->kobj.ktype =3D &die_kobj_ktype;
+       res =3D kset_register(&adev->ip_top->die_kset);
+       if (res) {
+               DRM_ERROR("Couldn't register die_kset");
+               goto Err;
+       }
+
+       res =3D amdgpu_discovery_sysfs_recurse(adev);
+
+       return res;
+Err:
+       kobject_put(&adev->ip_top->kobj);
+       return res;
+}
+
+/* -------------------------------------------------- */
+
+#define list_to_kobj(el) container_of(el, struct kobject, entry)
+
+static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
+{
+       struct list_head *el, *tmp;
+       struct kset *hw_id_kset;
+
+       hw_id_kset =3D &ip_hw_id->hw_id_kset;
+       spin_lock(&hw_id_kset->list_lock);
+       list_for_each_prev_safe(el, tmp, &hw_id_kset->list) {
+               list_del_init(el);
+               spin_unlock(&hw_id_kset->list_lock);
+               /* kobject is embedded in ip_hw_instance */
+               kobject_put(list_to_kobj(el));
+               spin_lock(&hw_id_kset->list_lock);
+       }
+       spin_unlock(&hw_id_kset->list_lock);
+       kobject_put(&ip_hw_id->hw_id_kset.kobj);
+}
+
+static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_en=
try)
+{
+       struct list_head *el, *tmp;
+       struct kset *ip_kset;
+
+       ip_kset =3D &ip_die_entry->ip_kset;
+       spin_lock(&ip_kset->list_lock);
+       list_for_each_prev_safe(el, tmp, &ip_kset->list) {
+               list_del_init(el);
+               spin_unlock(&ip_kset->list_lock);
+               amdgpu_discovery_sysfs_ip_hw_free(to_ip_hw_id(list_to_kobj(=
el)));
+               spin_lock(&ip_kset->list_lock);
+       }
+       spin_unlock(&ip_kset->list_lock);
+       kobject_put(&ip_die_entry->ip_kset.kobj);
+}
+
+static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
+{
+       struct list_head *el, *tmp;
+       struct kset *die_kset;
+
+       die_kset =3D &adev->ip_top->die_kset;
+       spin_lock(&die_kset->list_lock);
+       list_for_each_prev_safe(el, tmp, &die_kset->list) {
+               list_del_init(el);
+               spin_unlock(&die_kset->list_lock);
+               amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kob=
j(el)));
+               spin_lock(&die_kset->list_lock);
+       }
+       spin_unlock(&die_kset->list_lock);
+       kobject_put(&adev->ip_top->die_kset.kobj);
+       kobject_put(&adev->ip_top->kobj);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
+
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
         struct binary_header *bhdr;
@@ -492,6 +976,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device=
 *adev)
                 }
         }

+       amdgpu_discovery_sysfs_init(adev);
+
         return 0;
 }

--
2.35.0.3.gb23dac905b


--_000_CO6PR12MB5473C3CF13FE77DC10914F60822F9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Luben Tuikov &lt;luben.tuikov=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 10, 2022 6:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; StDenis, T=
om &lt;Tom.StDenis@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH v1 1/1] drm/amdgpu: Show IP discovery in sysfs</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add IP discovery data in sysfs. The format is:<br>
/sys/class/drm/cardX/device/ip_discovery/die/D/B/I/&lt;attrs&gt;<br>
where,<br>
X is the card ID, an integer,<br>
D is the die ID, an integer,<br>
B is the IP HW ID, an integer, aka block type,<br>
I is the IP HW ID instance, an integer.<br>
&lt;attrs&gt; are the attributes of the block instance. At the moment these=
<br>
include HW ID, instance number, major, minor, revision, number of base<br>
addresses, and the base addresses themselves.<br>
<br>
A symbolic link of the acronym HW ID is also created, under D/, if you<br>
prefer to browse by something humanly accessible.<br>
<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Tom StDenis &lt;tom.stdenis@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 486 +++++++++++++++++=
+<br>
&nbsp;2 files changed, 490 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index e4eb812ade2fa4..3a126dce8a2fe9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -772,6 +772,8 @@ struct amd_powerplay {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs;<br>
&nbsp;};<br>
&nbsp;<br>
+struct ip_discovery_top;<br>
+<br>
&nbsp;/* polaris10 kickers */<br>
&nbsp;#define ASICID_IS_P20(did, rid)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (((did =3D=3D 0x67DF) &amp;&amp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((rid =3D=3D 0xE3) || \<br>
@@ -1097,6 +1099,8 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_is_di=
rect_mapped;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ras_list;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_top&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ip_top;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static inline struct amdgpu_device *drm_to_adev(struct drm_device *dd=
ev)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 07623634fdc2f1..46e6e1352574f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -360,8 +360,11 @@ static int amdgpu_discovery_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);<br>
+<br>
&nbsp;void amdgpu_discovery_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_sysfs_fini(adev);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mman.discov=
ery_bin);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.discovery_bi=
n =3D NULL;<br>
&nbsp;}<br>
@@ -382,6 +385,487 @@ static int amdgpu_discovery_validate_ip(const struct =
ip *ip)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */<br>
+<br>
+struct ip_hw_instance {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject kobj; /* ip_discovery/=
die/#die/#hw_id/#instance/&lt;attrs...&gt; */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hw_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; num_instance;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp; major, minor, revision;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_base_addresses;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 base_addr[0];<br>
+};</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">[ke=
vin]:</span></div>
<div class=3D"PlainText">
<ol>
<li><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (W=
est European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; color: =
rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">use flex-array instead
 of zero length array is better to match kernel coding style and avoid some=
 compiler warning. eg: &quot;</span><span><span style=3D"text-align: start;=
 background-color: rgba(0, 0, 0, 0); display: inline !important; font-famil=
y: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">u32
 base_addr[];&quot;</span><br>
</span></li><li><span><span style=3D"text-align: start; background-color: r=
gba(0, 0, 0, 0); display: inline !important; font-family: &quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
; font-size: 11pt; color: rgb(0, 0, 0);">please
 use following macro helper to handle array size.</span><span style=3D"text=
-align:start;background-color:rgb(255, 255, 255);display:inline !important"=
><br>
</span><span style=3D"text-align: start; background-color: rgba(0, 0, 0, 0)=
; display: inline !important; font-family: &quot;Segoe UI&quot;, &quot;Sego=
e UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkM=
acSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11=
pt; color: rgb(0, 0, 0);">//&nbsp;</span><span style=3D"text-align: start; =
background-color: rgba(0, 0, 0, 0); display: inline !important; font-family=
: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">include/linux/o=
verflow.h</span><span style=3D"text-align:start;background-color:rgb(255, 2=
55, 255);display:inline !important"><br>
</span><span style=3D"text-align: start; background-color: rgba(0, 0, 0, 0)=
; display: inline !important; font-family: &quot;Segoe UI&quot;, &quot;Sego=
e UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkM=
acSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11=
pt; color: rgb(0, 0, 0);">-
 struct_size() - Calculate size of structure with trailing array.</span><sp=
an style=3D"text-align:start;background-color:rgb(255, 255, 255);display:in=
line !important"><br>
</span></span></li><li style=3D"display:block;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;font-size:11pt;color:rgb(0, 0, 0)">
<span><span style=3D"text-align: start; background-color: rgba(0, 0, 0, 0);=
 display: inline !important; font-family: &quot;Segoe UI&quot;, &quot;Segoe=
 UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11p=
t; color: rgb(0, 0, 0);">-&nbsp;flex_array_size()
 - Calculate size of a flexible array member within an enclosing structure.=
</span></span></li></ol>
<div><span><span style=3D"text-align: start; background-color: rgba(0, 0, 0=
, 0); display: inline !important; font-family: &quot;Segoe UI&quot;, &quot;=
Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bl=
inkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">On
 the other hand, do we really need variable length arrays?&nbsp; why not fi=
x size to 4?</span><span style=3D"text-align:start;background-color:rgb(255=
, 255, 255);display:inline !important"><br>
<span></span></span></span></div>
</div>
<div class=3D"PlainText">+<br>
+struct ip_hw_id {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset hw_id_kset;&nbsp; /* ip_d=
iscovery/die/#die/#hw_id/, contains ip_hw_instance */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hw_id;<br>
+};<br>
+<br>
+struct ip_die_entry {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset ip_kset;&nbsp;&nbsp;&nbsp=
;&nbsp; /* ip_discovery/die/#die/, contains ip_hw_id&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 num_ips;<br>
+};<br>
+<br>
+/* -------------------------------------------------- */<br>
+<br>
+struct ip_hw_instance_attr {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute attr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t (*show)(struct ip_hw_instance=
 *ip_hw_instance, char *buf);<br>
+};<br>
+<br>
+static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;hw_id);<br>
+}<br>
+<br>
+static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, ch=
ar *buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;num_instance);<br>
+}<br>
+<br>
+static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;major);<br>
+}<br>
+<br>
+static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;minor);<br>
+}<br>
+<br>
+static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *=
buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;revision);<br>
+}<br>
+<br>
+static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instan=
ce, char *buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_hw_instance-&gt;num_base_addresses);<br>
+}<br>
+<br>
+static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char =
*buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t res =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ii;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; ip_hw_instance=
-&gt;num_base_addresses; ii++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (res + 12 &gt;=3D PAGE_SIZE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; res +=3D sprintf(buf + res, &quot;0x%08X\n&quot;, ip_hw_instance=
-&gt;base_addr[ii]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
+}<br>
+<br>
+static struct ip_hw_instance_attr ip_hw_attr[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(hw_id),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(num_instance),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(major),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(minor),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(revision),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(num_base_addresses),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(base_addr),<br>
+};<br>
+<br>
+static struct attribute *ip_hw_instance_attrs[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[0].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[1].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[2].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[3].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[4].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[5].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ip_hw_attr[6].attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
+};<br>
+ATTRIBUTE_GROUPS(ip_hw_instance);<br>
+<br>
+#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)<=
br>
+#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_at=
tr, attr)<br>
+<br>
+static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct attribute *attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; char *buf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_instance *ip_hw_instance=
 =3D to_ip_hw_instance(kobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_instance_attr *ip_hw_att=
r =3D to_ip_hw_instance_attr(attr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_hw_attr-&gt;show)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EIO;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ip_hw_attr-&gt;show(ip_hw_inst=
ance, buf);<br>
+}<br>
+<br>
+static const struct sysfs_ops ip_hw_instance_sysfs_ops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D ip_hw_instance_attr_show,<b=
r>
+};<br>
+<br>
+static void ip_hw_instance_release(struct kobject *kobj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_instance *ip_hw_instance=
 =3D to_ip_hw_instance(kobj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ip_hw_instance);<br>
+}<br>
+<br>
+static struct kobj_type ip_hw_instance_ktype =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D ip_hw_instance_release,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;ip_hw_instance_sy=
sfs_ops,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .default_groups =3D ip_hw_instance_gr=
oups,<br>
+};<br>
+<br>
+/* -------------------------------------------------- */<br>
+<br>
+#define to_ip_hw_id(x)&nbsp; container_of(to_kset(x), struct ip_hw_id, hw_=
id_kset)<br>
+<br>
+static void ip_hw_id_release(struct kobject *kobj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_id *ip_hw_id =3D to_ip_h=
w_id(kobj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;ip_hw_id-&gt;hw_=
id_kset.list))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;ip_hw_id-&gt;hw_id_kset is not empty&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ip_hw_id);<br>
+}<br>
+<br>
+static struct kobj_type ip_hw_id_ktype =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D ip_hw_id_release,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;kobj_sysfs_ops,<b=
r>
+};<br>
+<br>
+/* -------------------------------------------------- */<br>
+<br>
+static void die_kobj_release(struct kobject *kobj);<br>
+static void ip_disc_release(struct kobject *kobj);<br>
+<br>
+struct ip_die_entry_attribute {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute attr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t (*show)(struct ip_die_entry *=
ip_die_entry, char *buf);<br>
+};<br>
+<br>
+#define to_ip_die_entry_attr(x)&nbsp; container_of(x, struct ip_die_entry_=
attribute, attr)<br>
+<br>
+static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;,=
 ip_die_entry-&gt;num_ips);<br>
+}<br>
+<br>
+/* If there are more ip_die_entry attrs, other than the number of IPs,<br>
+ * we can make this intro an array of attrs, and then initialize<br>
+ * ip_die_entry_attrs in a loop.<br>
+ */<br>
+static struct ip_die_entry_attribute num_ips_attr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ATTR_RO(num_ips);<br>
+<br>
+static struct attribute *ip_die_entry_attrs[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;num_ips_attr.attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
+};<br>
+ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */<br>
+<br>
+#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, i=
p_kset)<br>
+<br>
+static ssize_t ip_die_entry_attr_show(struct kobject *kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
attribute *attr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *b=
uf)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_die_entry_attribute *ip_die=
_entry_attr =3D to_ip_die_entry_attr(attr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_die_entry *ip_die_entry =3D=
 to_ip_die_entry(kobj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_die_entry_attr-&gt;show)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EIO;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ip_die_entry_attr-&gt;show(ip_=
die_entry, buf);<br>
+}<br>
+<br>
+static void ip_die_entry_release(struct kobject *kobj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_die_entry *ip_die_entry =3D=
 to_ip_die_entry(kobj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;ip_die_entry-&gt=
;ip_kset.list))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;ip_die_entry-&gt;ip_kset is not empty&quot;);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ip_die_entry);<br>
+}<br>
+<br>
+static const struct sysfs_ops ip_die_entry_sysfs_ops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D ip_die_entry_attr_show,<br>
+};<br>
+<br>
+static struct kobj_type ip_die_entry_ktype =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D ip_die_entry_release,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;ip_die_entry_sysf=
s_ops,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .default_groups =3D ip_die_entry_grou=
ps,<br>
+};<br>
+<br>
+static struct kobj_type die_kobj_ktype =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D die_kobj_release,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;kobj_sysfs_ops,<b=
r>
+};<br>
+<br>
+static struct kobj_type ip_discovery_ktype =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D ip_disc_release,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sysfs_ops =3D &amp;kobj_sysfs_ops,<b=
r>
+};<br>
+<br>
+struct ip_discovery_top {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject kobj;&nbsp;&nbsp;&nbsp=
; /* ip_discovery/ */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset die_kset;&nbsp;&nbsp; /* =
ip_discovery/die/, contains ip_die_entry */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
+};<br>
+<br>
+static void die_kobj_release(struct kobject *kobj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_top *ip_top =3D c=
ontainer_of(to_kset(kobj),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct ip_discovery_top,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; die_kset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;ip_top-&gt;die_k=
set.list))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;ip_top-&gt;die_kset is not empty&quot;);<br>
+}<br>
+<br>
+static void ip_disc_release(struct kobject *kobj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_top *ip_top =3D c=
ontainer_of(kobj, struct ip_discovery_top,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_top=
-&gt;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_top =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ip_top);<br>
+}<br>
+<br>
+static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
ip_die_entry *ip_die_entry,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const s=
ize_t _ip_offset, const int num_ips)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ii, jj, kk, res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;num_ips:%d&quot;, num=
_ips);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Find all IPs of a given HW ID, and=
 add their instance to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * #die/#hw_id/#instance/&lt;att=
ributes&gt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; HW_ID_MAX; ii+=
+) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ip_hw_id *ip_hw_id =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size_t ip_offset =3D _ip_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (jj =3D 0; jj &lt; num_ips; jj++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip *ip;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_hw_ins=
tance *ip_hw_instance;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip =3D (struct i=
p *)(adev-&gt;mman.discovery_bin + ip_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_disco=
very_validate_ip(ip) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; le16_to_cpu(ip-&gt;hw_id) !=3D ii)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto next_ip;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;=
match:%d @ ip_offset:%ld&quot;, ii, ip_offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We have a hw_=
id match; register the hw<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * block if=
 not yet registered.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_hw_id) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_id =3D kzalloc(sizeof(*ip_hw_id), GFP=
_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_hw_id)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_id-&gt;hw_id =3D ii;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_set_name(&amp;ip_hw_id-&gt;hw_id_ks=
et.kobj, &quot;%d&quot;, ii);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_id-&gt;hw_id_kset.kobj.kset =3D &amp;=
ip_die_entry-&gt;ip_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_id-&gt;hw_id_kset.kobj.ktype =3D &amp=
;ip_hw_id_ktype;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D kset_register(&amp;ip_hw_id-&gt;hw_=
id_kset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;Couldn't register ip_hw_id kset&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; kfree(ip_hw_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return res;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hw_id_names[ii]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; res =3D sysfs_create_link(&amp;ip_die_entry-&gt;ip_kset.kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;ip_hw_id-&gt;hw_id_kset.kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h=
w_id_names[ii]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Couldn=
't create IP link %s in IP Die:%s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_id_names[ii],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_name(&amp;ip_die_entry-&gt;ip=
_kset.kobj));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Now register =
its instance.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance =
=3D kzalloc(sizeof(*ip_hw_instance) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(u32) * ip=
-&gt;num_base_address,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_hw_insta=
nce) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;no memory for ip_hw_instanc=
e&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;hw_id =3D le16_to_cpu(ip-&gt;hw_id); /* =3D=3D ii */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;num_instance =3D ip-&gt;number_instance;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;major =3D ip-&gt;major;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;minor =3D ip-&gt;minor;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;revision =3D ip-&gt;revision;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;num_base_addresses =3D ip-&gt;num_base_address;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (kk =3D 0; k=
k &lt; ip_hw_instance-&gt;num_base_addresses; kk++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&gt;base_addr[kk] =3D ip-&gt=
;base_address[kk];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_init(&am=
p;ip_hw_instance-&gt;kobj, &amp;ip_hw_instance_ktype);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_hw_instance-&=
gt;kobj.kset =3D &amp;ip_hw_id-&gt;hw_id_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D kobject_=
add(&amp;ip_hw_instance-&gt;kobj, NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;%d&quot;, ip_hw_instance-&gt;num_instance);<br>
+next_ip:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_offset +=3D s=
izeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_header *ihdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct die_header *dhdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *die_kset =3D &amp;adev-&=
gt;ip_top-&gt;die_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 num_dies, die_offset, num_ips;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t ip_offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ii, res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bhdr =3D (struct binary_header *)adev=
-&gt;mman.discovery_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ihdr =3D (struct ip_discovery_header =
*)(adev-&gt;mman.discovery_bin +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(bhdr-&gt;table_list[IP=
_DISCOVERY].offset));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dies =3D le16_to_cpu(ihdr-&gt;num=
_dies);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;number of dies: %d\n&=
quot;, num_dies);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; num_dies; ii++=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ip_die_entry *ip_die_entry;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; die_offset =3D le16_to_cpu(ihdr-&gt;die_info[ii].die_offset);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dhdr =3D (struct die_header *)(adev-&gt;mman.discovery_bin + die=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; num_ips =3D le16_to_cpu(dhdr-&gt;num_ips);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_offset =3D die_offset + sizeof(*dhdr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Add the die to the kset.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * dhdr-&gt;die_id =3D=3D ii, which was checked in<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * amdgpu_discovery_reg_base_init().<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_die_entry =3D kzalloc(sizeof(*ip_die_entry), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ip_die_entry)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_die_entry-&gt;num_ips =3D num_ips;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kobject_set_name(&amp;ip_die_entry-&gt;ip_kset.kobj, &quot;%d&qu=
ot;, le16_to_cpu(dhdr-&gt;die_id));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_die_entry-&gt;ip_kset.kobj.kset =3D die_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_die_entry-&gt;ip_kset.kobj.ktype =3D &amp;ip_die_entry_ktype;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; res =3D kset_register(&amp;ip_die_entry-&gt;ip_kset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
Couldn't register ip_die_entry kset&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ip_die_ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ip=
s);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *die_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_top =3D kzalloc(sizeof(*a=
dev-&gt;ip_top), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_top)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_top-&gt;adev =3D adev;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D kobject_init_and_add(&amp;ade=
v-&gt;ip_top-&gt;kobj, &amp;ip_discovery_ktype,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;dev-&gt;kob=
j, &quot;ip_discovery&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Couldn't init and add ip_discovery/&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset =3D &amp;adev-&gt;ip_top-&gt=
;die_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_set_name(&amp;die_kset-&gt;ko=
bj, &quot;%s&quot;, &quot;die&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset-&gt;kobj.parent =3D &amp;ade=
v-&gt;ip_top-&gt;kobj;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset-&gt;kobj.ktype =3D &amp;die_=
kobj_ktype;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D kset_register(&amp;adev-&gt;i=
p_top-&gt;die_kset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Couldn't register die_kset&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D amdgpu_discovery_sysfs_recurs=
e(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
+Err:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;adev-&gt;ip_top-&gt;=
kobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
+}<br>
+<br>
+/* -------------------------------------------------- */<br>
+<br>
+#define list_to_kobj(el) container_of(el, struct kobject, entry)<br>
+<br>
+static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)<b=
r>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *el, *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *hw_id_kset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_id_kset =3D &amp;ip_hw_id-&gt;hw_i=
d_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;hw_id_kset-&gt;list_lo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_prev_safe(el, tmp, &amp=
;hw_id_kset-&gt;list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_del_init(el);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;hw_id_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* kobject is embedded in ip_hw_instance */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kobject_put(list_to_kobj(el));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;hw_id_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;hw_id_kset-&gt;list_=
lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;ip_hw_id-&gt;hw_id_k=
set.kobj);<br>
+}<br>
+<br>
+static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_en=
try)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *el, *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *ip_kset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_kset =3D &amp;ip_die_entry-&gt;ip_=
kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;ip_kset-&gt;list_lock)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_prev_safe(el, tmp, &amp=
;ip_kset-&gt;list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_del_init(el);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ip_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_discovery_sysfs_ip_hw_free(to_ip_hw_id(list_to_kobj(el)))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ip_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;ip_kset-&gt;list_loc=
k);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;ip_die_entry-&gt;ip_=
kset.kobj);<br>
+}<br>
+<br>
+static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *el, *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kset *die_kset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset =3D &amp;adev-&gt;ip_top-&gt=
;die_kset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;die_kset-&gt;list_lock=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_prev_safe(el, tmp, &amp=
;die_kset-&gt;list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_del_init(el);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;die_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kobj(el)=
));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;die_kset-&gt;list_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;die_kset-&gt;list_lo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;adev-&gt;ip_top-&gt;=
die_kset.kobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;adev-&gt;ip_top-&gt;=
kobj);<br>
+}<br>
+<br>
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */<br>
+<br>
&nbsp;int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr=
;<br>
@@ -492,6 +976,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_sysfs_init(adev);<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.35.0.3.gb23dac905b<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473C3CF13FE77DC10914F60822F9CO6PR12MB5473namp_--
