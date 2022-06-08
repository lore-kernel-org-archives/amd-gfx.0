Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C926C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 11:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F5510ED19;
	Wed,  8 Jun 2022 11:41:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6340810ED19
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 11:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0fyIoFdPVt5cnoq/cGFeWuV3O7SK1BCkeoQ7t8BfFvmGayCmj9ryZbQPS9J2MzLww675w1BbB8EPhjiglpbMnhVwwDM25m5iRpZFkfIeAhwwrUZy7eY+3Am3Z9yKwPy4GLyL7+bu+MCKG4wMJ2QSEDqHj/BlRw5MVzQXI53rTLHqM7qOss77MhljvF/GRvSK123aAD/UfVOCPaRlRXEFT0uBBr/wbW83P1RSbTd2Bd2LZrPHtwgBM1b1jBFjwMhg+wYRlMheL3pzg4s2WVp2rF2aseY6k5F7+Di5z1pGSX4y++ducJUlchZEknbplG0SigyV70L7CqCGXPwr8n/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdoqFnn4bVrbZqRfcIo8GXIrkdCltdJ+eWR64b3jG1Y=;
 b=PqCKvaeD6X5VMS1qkm2y+P9+ltExcmAkG5kW2kzTwq/TOsHShAz6DT1Q3jCaajqmszE44K0J42+2aYdbG/523cjtkXmFY4U3PFIEn+F9YeZ0Qo+gzYqRs7dG9uOHQwxnt59bJGtqM5j9Fvs0wkgye2aJalsxH8N8DniV+3v0/rr2ykCoaZXZ4v+wkaAo8GRTXBFr2SDsWFRXX5+7ezkDHgdqnU/+IprduX+YDExBHULMg/w59zzFCB+5FvvdewaSaZ3ysATUbB5vjmKQPWQZrkecbHV7lN7tGWttuvq6HlH36RRTvf7W5Ou4DctiG64m4svxk8D3cEdxlxAEb5/qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdoqFnn4bVrbZqRfcIo8GXIrkdCltdJ+eWR64b3jG1Y=;
 b=cjx9xc+kWLmvu0Xt8hkMD4ZvGHCANPa5WVvg2E8scBvQFxbLl11P7EP1lsdDMShhN0QB9O/aJ3vtSuAbHJgFhz9HZybEzkfoxXLMjDO5kgGVzqvb7eknqiiP3+DEqcU2qyjjwQtR3Koq1kpsJbXxsB0KX2eTFQqpSnkCq3PIuCI=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by BN8PR12MB3249.namprd12.prod.outlook.com (2603:10b6:408:68::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 11:41:25 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824%4]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 11:41:24 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Remove field io_link_count from struct
 kfd_topology_device
Thread-Topic: [PATCH] drm/amdkfd: Remove field io_link_count from struct
 kfd_topology_device
Thread-Index: AQHYeywiYfCrPXvg90C0d0Yd5bywJ61FYuZg
Date: Wed, 8 Jun 2022 11:41:24 +0000
Message-ID: <SN1PR12MB25756E95D17F95CD769E9F2FE3A49@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220608113719.1483269-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20220608113719.1483269-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T11:41:22Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6940b281-ebf5-4a08-91ce-132ef8695139;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-08T11:41:22Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6fc8e79d-7a13-4d2f-879b-6dea50261f9f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60ded71-d039-4d18-5274-08da4943d14d
x-ms-traffictypediagnostic: BN8PR12MB3249:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3249527AFA35076C45F0A1EEE3A49@BN8PR12MB3249.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WqySXogwxf0pheN+Hh8FkMk6dEGXHqE5ziL+tB7U+EJnr8Dw2NY2pftWOX2TliJ2/6FC321OgjrcI9WdEcgQ1G4J0ex9xRGMoyWU7wGawGza4Xgdszzfo2fEwThRwQoDkFbNh4SKBJ+C9Wl2FTsAIDHsg+weQUFbAqOm9Sdnd5291xO6U14yRR/tdGHZbJyyT8LVyPXTgQkVgdjhoJIBEWrdiz4J81Wghzuyi/c6eFw+7B+dUK4o49gr0MnLCUjF0IDnkJl+c7rKvBmlIDJSYp6ZU61NpjoXrFUfgAUh8AwWRfuPiHqhkzIdaAFSprJNgvWJFju/aql6+fUuHkFmcfC4/lsBHYNvGYmpuu84fnJdEHEvBbBLI3CTmEoHlIVfOR/Gfrw25TDR/6Wrw/k5ETd8ZRUfUwmQh05nkCma6sle498JDfO7FxSNDX4pKfNTguiU/AOUIZIcECl6rtRt+Xhcj/xKXqe8900AELS0VfiWAtNtgBkHYPf1mD9YkAOHyYSjSn4v2dP2lnFqfchxuBC8Crs4+5UZSBS4KaauV/q3g29/BH5W49cVpIlsCroiNpTx2k/ScQAQha/8WBjNeqXUNR/N/vhgfaKF06cJHnCshsJA0md4KW899ES4FCl+Ds48v6QLLDHFH39mIr+L2TZLGYhvPpNZfgUJ6zf+7YGGD4unWTgcKBVwpQx44zyenjcJZlZ3BK2rIyHhoUBDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(76116006)(8676002)(66476007)(64756008)(508600001)(71200400001)(55016003)(7696005)(9686003)(53546011)(38100700002)(86362001)(38070700005)(2906002)(66946007)(6916009)(66446008)(6506007)(26005)(83380400001)(186003)(316002)(122000001)(5660300002)(52536014)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OhbbxiahD2+TU8dW5vQwQW+W9+sOD7P1O8Ak9JYLSHCSBSugFko4UUEooYqj?=
 =?us-ascii?Q?8ZdBkIs+WIEqbCWpvrhM9ujr++dLtIpWrzK9gyp+x7wtMkxv+Fsxw/vn+bGf?=
 =?us-ascii?Q?YTSqYobBEE3E5RaCXq04WuzQ8wwNggRz7/lz6TiYEuVaUvC/D0wLAK8hvYIN?=
 =?us-ascii?Q?Y5kSz+pZWZW0EX5l86PFYi1pxSZhwpcld1Z9Q2hwiESYtKZffLXgcr+sFm9+?=
 =?us-ascii?Q?0d24PSXJE8GE/ORu5ZrOoIEbA1QM1P11Ex2BSsU3N6jbCAzTmty1g3OVuluY?=
 =?us-ascii?Q?4CaRcrhwd0zP3WdAMJxnWwG6Buh9Ws46eJ01TygQUvHAuj84i/GvIo4LOVuE?=
 =?us-ascii?Q?Fps5f4jIzj5cTKkBwsuovW+qK7iukWzRgmTqVRqeCKqMhOiRMfl68qheQDuJ?=
 =?us-ascii?Q?3rhiLbmZaq0GrCp+r8RTvLDT3dWME2IQPQ8/ZaEoFPXxat5MQOQiX9A7DgRk?=
 =?us-ascii?Q?xVNdPmTd+db9GyXnsOxBgLVWWUrtqhh3v0f5EiZ6+bLaeOOeWORVb+G19SOU?=
 =?us-ascii?Q?moAnEb2KHQbAxzqp9cy6zMka9bZf+uk4SXfjcVB8feoHDzFQw1uMnbw51WpU?=
 =?us-ascii?Q?LMUV3VXtQiHdbHmyqdY0Gtd4rvFvlpEgaN9OPy/A4q/kxTi57HJOvy0QTuC2?=
 =?us-ascii?Q?L3QZqbvhnBT57O+DXwjlewigZaxRk21hI1ZNHlkH3b3fd5pj60/8VCKDTNEw?=
 =?us-ascii?Q?pWZRg4rRUqvfrh0px4zrZCyPdmoufEIb17s7wZTjqsa3SYt/PkbKWQoroYje?=
 =?us-ascii?Q?gHyACqeXEsWSJYK2Zk5Q7/oB/CuhqOC4TSy35tV/n2y+z/0WuB6+Fsj1QlyQ?=
 =?us-ascii?Q?SgvRXkLv8ZBNsJxY2w0wPi079iomt+Xhsy8z8GDMdtfAf6YCelVSRvVe/P1J?=
 =?us-ascii?Q?mAubbLbljQOF1FylydESKAlupi5GnbbyLeKYKPufIGbxn1eLgRwN0/ElKmyt?=
 =?us-ascii?Q?JMBIaM/HihcTbZi9O8sPEc4VOL0csI5rWFhwqYPglj/u8worFjKIghvqu6qn?=
 =?us-ascii?Q?zjLu83VP99AEJZNtr4XiOfQ7wDomSgaPNHf/zQAJhSPcpvEHCATGpanzG/Sy?=
 =?us-ascii?Q?d3DKslhKM3RTmojJ6sNMpXVcTEQgWY9s5WML3yCynAD16un/sPqpB+yAsdDA?=
 =?us-ascii?Q?VF+Q9jfxBwe6WlNNASw/aca1ONqXyUsi6plbxfCtNV/i9L8RV6r83jNtd568?=
 =?us-ascii?Q?7KWQRewuZfelw9hiDcADDXUKFHLbtpbDgpQ8ceqEl2sfw71LuB12LjUxbAPo?=
 =?us-ascii?Q?NezW6jjrRw/1RsHKaZQ9nsw9Xse8hDrRorGSIHbC7dT6iffxRvUMFAZSYY6j?=
 =?us-ascii?Q?XsCFPaVi+CpTKLO+CqnRHHlv/izLJzgJFH5VkN8Jffs/nCxDFq8cz4vibLN5?=
 =?us-ascii?Q?ph4uwyNcerrZPGmy/K8NQDJo4V6hAPg9R64l5sLi7M+uBMJ4Y6/RjxDnxXaF?=
 =?us-ascii?Q?31fejleTWMeZFu3NypLBB7uuwT9+xFpsSGJwPmfOvGUsFEN5h9nmqr9Yuw0C?=
 =?us-ascii?Q?fTharyLi9KUBFouWHAdsx5AfJ2FPaq+CXkMCC1DTjLmPwEF6W5tzMS1338HH?=
 =?us-ascii?Q?7ho7jJOVVNAjA2NkLMTM/j65sDlmC/OEz0s/i4UnBGKdfdMJhKsbrP594eGW?=
 =?us-ascii?Q?us7BgfyxLiPi92nEonnsDWV2SMQyM5UHmFje6Zs/ntA2kxw5ETXlukX4vxRV?=
 =?us-ascii?Q?xditsdKqezkDqg9jhoxGd+F0kg+AaN+vz3U88Gy06ZbYIGBT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60ded71-d039-4d18-5274-08da4943d14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 11:41:24.9019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x38yKOtNscWLQGLz5QJgzK6yjiouZuJ5WbmekmQuW7tjMt9wHWO4zYmSBAlNym9GemjH36uox9eiaR+AGBljyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3249
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

Ignore the patch sent a bit early.

Regards,
Ramesh

-----Original Message-----
From: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>=20
Sent: Wednesday, June 8, 2022 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdkfd: Remove field io_link_count from struct kfd_top=
ology_device

The field is redundant and does not serve any functional role

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -  drivers/gpu/drm/amd/amdkf=
d/kfd_topology.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index cbfb32b3d235..a5409531a2fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1040,7 +1040,6 @@ static int kfd_parse_subtype_iolink(struct crat_subty=
pe_iolink *iolink,
 			props->rec_transfer_size =3D
 					iolink->recommended_transfer_size;
=20
-			dev->io_link_count++;
 			dev->node_props.io_links_count++;
 			list_add_tail(&props->list, &dev->io_link_props);
 			break;
@@ -1067,7 +1066,6 @@ static int kfd_parse_subtype_iolink(struct crat_subty=
pe_iolink *iolink,
 		props2->node_from =3D id_to;
 		props2->node_to =3D id_from;
 		props2->kobj =3D NULL;
-		to_dev->io_link_count++;
 		to_dev->node_props.io_links_count++;
 		list_add_tail(&props2->list, &to_dev->io_link_props);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 3e240b22ec91..304322ac39e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1819,7 +1819,6 @@ static void kfd_topology_update_io_links(int proximit=
y_domain)
 			 */
 			if (iolink->node_to =3D=3D proximity_domain) {
 				list_del(&iolink->list);
-				dev->io_link_count--;
 				dev->node_props.io_links_count--;
 			} else {
 				if (iolink->node_from > proximity_domain) diff --git a/drivers/gpu/drm=
/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2fb5664e1041..9f6c949186c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -130,7 +130,6 @@ struct kfd_topology_device {
 	struct list_head		mem_props;
 	uint32_t			cache_count;
 	struct list_head		cache_props;
-	uint32_t			io_link_count;
 	struct list_head		io_link_props;
 	struct list_head		p2p_link_props;
 	struct list_head		perf_props;
--
2.35.1
