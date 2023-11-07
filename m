Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA54C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 05:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C3E10E4AE;
	Tue,  7 Nov 2023 05:28:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2910E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 05:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJq2k5j6RyaPsCFwQrNSweSIPuHdOZiwpnhGZofpUkiNktlbh/xcuHeo1Z3sqhPMGX1vN1ey1Dm4ID8ooiTdIkaedtLVQOL5QXbx2mXSKeslCHcxZcWVhb5uDIu5c7Sux5Q9UylKi5r+PfBHDNrsIFOdmBFq8IqNohSbN2Vq0/anh3kOEnUvOfb7V5oLsyu+VaMQs5dkZ+lcVxaKzIgINJuCL2Xx3n4dZF136yJcBCrTlobaiEZcXt3h7b4ctMWPLxV8ITbCvkOcbyaKtXWaJ5/xioGvvzr7GCZBw3ntsPoj40y43P1mOmWCcn4ZD/Aw1LIJZOmyRsOsP0S++VrbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX4zSrh9SpRRACpS+63QXDogVbmJ3bqsYWuebjZWGTM=;
 b=PP079wkx32xul9JAcjXs9L9R/Z4/r+Gh6S+CgCACyo53NwHAogSfrzks2Hh56bcN13NBUwRe5zmWfPtkiI3eRRwF6MU2GzRZq5dCyno9Yc4SaYiELaBEPfQbITVbXC0eZZabky8soISQ+vdrqwbJxYpteaQy7F/Lz07U3HK/CxKuZJGLdpOQ0F9cdKmj8HMp5qIBA2S8MIZnGhaKb9n34V8t5p7KeM54mZepo0V2K8SwMoWdDWQRPqxexLWEeD52pWWvI7Pi048Q0H1jse6qakmDyzrsmwoVCvx2glUQTVFd32rDKkm3h89t4I7U1u1b37J048FtsvDcc5qk5wGoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX4zSrh9SpRRACpS+63QXDogVbmJ3bqsYWuebjZWGTM=;
 b=KfXoSEsh4OkRDii8kgcicRuAYOSSO4mzqbDdzs8h+TUsWu2ErnKHvZrwsYGNaSdxmBUA5oZcAAkwntItB3jxcIIWA//LHAY/gX4o3ATvD1IGMmUbfIi80QDs8iNQshYTBN1IhAL76zG1UesT1Q8BxeodpoBBZxCUjA1Z9lM4/Uo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 05:28:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 05:28:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: expose the connected port num info
 through sysfs
Thread-Topic: [PATCH 2/2] drm/amdgpu: expose the connected port num info
 through sysfs
Thread-Index: AQHaESdxYoGMhgaaF0Ktrg9lzjK+kbBuU/4A
Date: Tue, 7 Nov 2023 05:28:36 +0000
Message-ID: <BN9PR12MB525745CEA405D3560ABEDF7EFCA9A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231107030611.31109-1-shiwu.zhang@amd.com>
 <20231107030611.31109-2-shiwu.zhang@amd.com>
In-Reply-To: <20231107030611.31109-2-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2251fafa-a841-418b-972a-2ced475ab5b4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T05:27:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5857:EE_
x-ms-office365-filtering-correlation-id: d9443cce-c2ac-44ab-2831-08dbdf526439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6wgPQZh5JaNcf69AT0/7V3nAiSPcw8VFcbmJ61eSeiThHXsIJx/Rs7aYQWPbexkAa7GzaTQwHqXSBKRl/wGNnizBBk0XcYd/FlSpz0hQcFVeB0zVT6WHGwQG6cjfpP50Bh9SjH77QJuYg4rNEFweQLvP4txYYHIAEf25/s6h+yz+jcAmlFgTCk46FOMpdYbtDvcu/Ia5nJ37gsEQmQZ2Yopp2jR0uTIQVc7Xh49yqFLeGlucgiZxT/0O/FLCMNa2xsrENJuhmlAf3/zQdhsBZoY9x9RF0LP8HHZS1PD9YWKP2n9KFlxbJZCQ5Ee5mzU/xpPuVnWoHxJqyQUfWpErWxBUkHktupYS40XR7DM/k3uYNfU5cfWYBfGQzokMgAhVxE904j+CBj9fG93BNJoZhXTSuz08gtgY4O9/Nq+UyyG8StDzJSrcEpfAStFqjtBtwyyDS5GBM/UNd8Y3M5zXJMgJZU0HYzxv6F4TIUZYuXmAUWYjJIQ/BLWNXlLXGy0FyZj86eXoGj9eh5brMqWskdQGs07HirlLJ7HblW4U6iDZVa44ReNxs+ScfPlCt3QxYeZjON1C9K1wbXvH3jnWDJb9IilvYnsuKKBL6SsiEyDniSFTzqTS3f6nBRC0BMu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6506007)(7696005)(478600001)(9686003)(71200400001)(83380400001)(26005)(2906002)(41300700001)(5660300002)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(316002)(110136005)(52536014)(8936002)(8676002)(38070700009)(33656002)(38100700002)(86362001)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfjzMSosn+wcke0/NJ4lRWcgAVgfyzjjJQHjlN8O6yTaq9OGpSvKk4bvGLdf?=
 =?us-ascii?Q?uhq9syjS+2wYFQdHjjiyk/04DPELlKY1nIcZWngiGf2z8PhgRQInVaxKdWb9?=
 =?us-ascii?Q?fDbgmtbDqu5qIVFqi+ypLjie4oo341xsz5vP+RENBKydnc+PAYjfq6bD0Eve?=
 =?us-ascii?Q?nvIVz85DoN3KiMRQtad+awj4Bg3ejYKtWZWKI0g2XjN679J31WHSqNdw2/RM?=
 =?us-ascii?Q?TZ8z1nRGnuO1UEwlQuuFLebpJQ67e9EPyiqA5mLaoWq2yVzD+XlZNRvsS/L0?=
 =?us-ascii?Q?U/NnU57ykm8LuEGT8lYGVBYUYL6K13Ad4Y48hgcKIWcyYrUgkaOk2k7ZurUI?=
 =?us-ascii?Q?+1DrZwjJkvwSYbUzsqHxl80S2zY7TlhxkmKdG7wnsb71EVPtLzz5WMFvyJWe?=
 =?us-ascii?Q?ywqXD7vnC+WCQz/JmXrZcmO6WhJ7kfr4Fut4cSOa7co0J3Ht/fpXXefwBZpK?=
 =?us-ascii?Q?d5oGSQ9wtkLa4RaOJwlbyH83065ab75KuCkF3EmxhTYBC98TMVFxDchWLiks?=
 =?us-ascii?Q?Ivt+JPlU2xu3FtXG+GzKck8QJsTOarBI8zs9zQAsSu2ibLx7jEHJpEWJS83v?=
 =?us-ascii?Q?h8I+6KgRWFQpVPzPvAgpxlWOWGdtKRBOCM9yA9ZGAktzhyCFL24T/bM5rP0Y?=
 =?us-ascii?Q?XLNokO4ZlMmfHAm7oov/28iAdi4pTGnXdBA4mPD44Gl6+zYBTm/ZOKGjWvNV?=
 =?us-ascii?Q?ionbIOfSkG+Fw/YHQ3Zfjuk6x0DbdPZyOWyUJPZyI1Fu0Fj0OVrphu+JfULa?=
 =?us-ascii?Q?c40c1T0rG225qXOwndCh0Q1M2YAre4dAaDMtB6tzrvThif+PYnQrUJB8EOFv?=
 =?us-ascii?Q?FvpKHJtkeJUiyU7h6egXQxYYLTw8QkwCMY/QGGis1t6Xl7ZnLOnJbC07Cv5w?=
 =?us-ascii?Q?jp5c5O4MgWtEyyIhzzMh3lR6Cg4sZcHLGEK5hhsbFI/6vx91XDzATpZuQdzC?=
 =?us-ascii?Q?SQypeG+zLPXTqmoddvBwDGFyXZaXAElsFnh5CxSKxGHdonAdrPKgesjKiHJ6?=
 =?us-ascii?Q?HX4ggyyKlD4Z3AURmaybC/sFbmZTcs/tjlTcfu2CzuH4CMwEBDWoR2ByVY2Q?=
 =?us-ascii?Q?EPLda04fQJ646PW9A6KE3EFQHNcmBJvPaMtE9JCINMJ4bLZOHwnsgEbrwDo2?=
 =?us-ascii?Q?KRtP8xEtAGXYJuFIfvDSqfhn/SjO0Z4hJZOJ0+UWMkWaNPS7sF7+pnO9LEEx?=
 =?us-ascii?Q?54IX2f/EbvZ8IFlZ4V/bzc/IORivlTgqhRFQdprP9SsmeunOMYJcvU6tCub/?=
 =?us-ascii?Q?A5187kcFYbePUyvLz5kuoSdk12VLX5UqReUr/kD3wn4Y4UV2dO6Q4pcZO3sy?=
 =?us-ascii?Q?3/f4IvEMrGuebIrACSDq8+wBMmTrXvE6pb1Kv6Y/g1I4c7MiVbGSqxOo9bYZ?=
 =?us-ascii?Q?KlVSkzOrYn0s2h7k7kmTJTJHVJaXfO+j9RbQU+ES6WyEydtMu6a+UZynmEEb?=
 =?us-ascii?Q?n1CfP7i/dE2VeLVIBLOmBaH4Pb1NebDVsfiii32uE+MbLG7a099VlBvM7EM+?=
 =?us-ascii?Q?c0nkYM+xwzO9ire9Vg3KkIugqbDC3kqe+86Wl3vN75VxhCWYhpghz+M3aGNr?=
 =?us-ascii?Q?M9ympNo5wItksB8DTfZf8nS/ycsuw+WoQk7nK9fO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9443cce-c2ac-44ab-2831-08dbdf526439
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 05:28:36.4794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXV8Xv3NL+M+vdBQnL5E9/Z5gZgpsAHarr2PdOBB1hh1uac6k2Krqvcq9uDZj1IK2C3Ecs2lIWSdY0W1jjEmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Tuesday, November 7, 2023 11:06
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: expose the connected port num info through=
 sysfs

By catting the xgmi_port_num sysfs node, it prints out the info in the form=
at of <src node id>:<src port num> -> <dst node id>:<dst port num> for one =
xgmi link.

For example, in case of 4 sockets fully and evenly connected setup, it woul=
d be like as below for the first node in the hive.
01:02 -> 02:03
01:03 -> 02:02
01:07 -> 03:04
01:04 -> 03:07
01:06 -> 04:05
01:05 -> 04:06
Based on the fact that there is two xgmi links between each socket pair,
"01:02 -> 02:03" means that the current socket in question use the port 2 t=
o connect with port 3 of the second node in the hive and so on.

v2: print out the src/dst node id for each xgmi link (lijo)
v3: replace the current_node++ with +1 to align with dst node (le)
    and use the dev_err instead of pr_err (lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 2b7dc490ba6b..4bce96300e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -372,6 +372,38 @@ static ssize_t amdgpu_xgmi_show_num_links(struct devic=
e *dev,
        return sysfs_emit(buf, "%s\n", buf);
 }

+static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
+                                       struct device_attribute *attr,
+                                       char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.top_=
info;
+       int i, j, size =3D 0;
+       int current_node;
+       /*
+        * get the node id in the sysfs for the current socket and show
+        * it in the port num info output in the sysfs for easy reading.
+        * it is NOT the one retrieved from xgmi ta.
+        */
+       for (i =3D 0; i < top->num_nodes; i++) {
+               if (top->nodes[i].node_id =3D=3D adev->gmc.xgmi.node_id) {
+                       current_node =3D i;
+                       break;
+               }
+       }
+
+       for (i =3D 0; i < top->num_nodes; i++) {
+               for (j=3D0; j < top->nodes[i].num_links; j++)
+                       /* node id in sysfs starts from 1 rather than 0 so =
+1 here */
+                       size +=3D sysfs_emit_at(buf, size, "%02x:%02x ->  %=
02x:%02x\n", current_node + 1,
+                                             top->nodes[i].port_num[j].src=
_xgmi_port_num, i + 1,
+                                             top->nodes[i].port_num[j].dst=
_xgmi_port_num);
+       }
+
+       return size;
+}
+
 #define AMDGPU_XGMI_SET_FICAA(o)       ((o) | 0x456801)
 static ssize_t amdgpu_xgmi_show_error(struct device *dev,
                                      struct device_attribute *attr, @@ -41=
1,6 +443,7 @@ static DEVICE_ATTR(xgmi_physical_id, 0444, amdgpu_xgmi_show_p=
hysical_id, NULL);  static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_sho=
w_error, NULL);  static DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_sho=
w_num_hops, NULL);  static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi=
_show_num_links, NULL);
+static DEVICE_ATTR(xgmi_port_num, S_IRUGO,
+amdgpu_xgmi_show_connected_port_num, NULL);

 static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
                                         struct amdgpu_hive_info *hive)
@@ -446,6 +479,13 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgp=
u_device *adev,
        if (ret)
                pr_err("failed to create xgmi_num_links\n");

+       /* Create xgmi port num file if supported */
+       if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD=
_FLAG) {
+               ret =3D device_create_file(adev->dev, &dev_attr_xgmi_port_n=
um);
+               if (ret)
+                       dev_err(adev->dev, "failed to create xgmi_port_num\=
n");
+       }
+
        /* Create sysfs link to hive info folder on the first device */
        if (hive->kobj.parent !=3D (&adev->dev->kobj)) {
                ret =3D sysfs_create_link(&adev->dev->kobj, &hive->kobj, @@=
 -476,6 +516,8 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_d=
evice *adev,
        device_remove_file(adev->dev, &dev_attr_xgmi_error);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
+       if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD=
_FLAG)
+               device_remove_file(adev->dev, &dev_attr_xgmi_port_num);

 success:
        return ret;
@@ -492,6 +534,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgp=
u_device *adev,
        device_remove_file(adev->dev, &dev_attr_xgmi_error);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
        device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
+       if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD=
_FLAG)
+               device_remove_file(adev->dev, &dev_attr_xgmi_port_num);

        if (hive->kobj.parent !=3D (&adev->dev->kobj))
                sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
--
2.17.1

