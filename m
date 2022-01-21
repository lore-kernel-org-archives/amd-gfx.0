Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566AFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 01:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F074A10E58B;
	Fri, 21 Jan 2022 01:49:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF24710E5E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 01:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3G69srFpr8TGiouIrTi0t6M13UFOeM0bWCFVdweaoponpei6F3+bRSHn1a1bWMtFwDqxaRz7pqan6G4BzT1q0uLrQAHB5LopPg6Yt4KwwIHhYDK5eO+YGE9FEZ66lrP88uH1kYbZ6b6WhIF9PZkptzLkkDyyjFG7pFCNcU9VafRywfb9KDAUJef/pMiRQrGK030vDkLsy4Wp/kos6obR9+U0Ny1hZ4rMtuZ7XJe1zvmIgRUozcZbv/JnQ21qR+IGipX1z4J+w3O9VMPQ8eGAH9SO4BFXOj41L+/Db+UiJfqASqi/GSd8mTG1TLvhaXaryEOAax1fEdCnVF6xqTOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f7jpiPvM5Xr2TgG51g8C2Wes+hl0JEW1qAGNoTitKE=;
 b=ASo/Z35g8G+lEFO4+yvHD0o3coFoNlMkMyBcUJ/uDgCMvjSfkw4DSyg7pqq/CiWYAerNmHICMb4B5deyF8lMG8hWKYephKYlOzrgd9t9N7189b5TYRjgnJtY0tyGPBVzMI6RjxQgGKJjdjp8ybAhODH+ELilco6nnh7O2K0hVyeLGxi1MT3y6wgDUJGHuYxv/jSUrEZU32E2yb5U26RNBLhCz7FcRB/pY72PWbt2AM+Ylt/osAEdLOu2Hrkwk1xeg8674XVXg6pUEwgPDzkDvL3+VnrP9/5BUuM49e72kmigdE3Hyk85xTg5IhuoItte04JLqcNZYdgnQg6PxLEWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f7jpiPvM5Xr2TgG51g8C2Wes+hl0JEW1qAGNoTitKE=;
 b=e85wb9UBxOKiWv2tBDjOBzdc1SRPCC0OV4F/eqmvWBuP0Oc+geNKM/Wcb6lJYygOZWoG5CYWLrNh9dxk3ppetafzQPwSQ+BROJDm7M3JZWVUWtznvDBJw4oWbV8cniux8DkRyMKkY02+p9Tj65PFILLgRgnAMe23H5oPDrl6wnc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN6PR12MB1828.namprd12.prod.outlook.com (2603:10b6:404:108::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.11; Fri, 21 Jan 2022 01:49:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:49:38 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in
 dp_wait_for_training_aux_rd_interval
Thread-Index: AQHYDig4nekKuvD7bkuvUqhbvq8ctKxstVvA
Date: Fri, 21 Jan 2022 01:49:38 +0000
Message-ID: <DM5PR12MB2469737FA78BF772FEE50E59F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120180429.616236-1-alexander.deucher@amd.com>
In-Reply-To: <20220120180429.616236-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T01:47:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ff4636b1-1285-4738-8745-ecb2112cd033;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T01:49:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d8b9b7f8-b9f2-404c-90fa-6451f96f0806
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa6ccc4-2155-477a-c112-08d9dc804904
x-ms-traffictypediagnostic: BN6PR12MB1828:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1828BE57C753D1B6AC3A5629F15B9@BN6PR12MB1828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvqMr4qzNpNfvW9sPFrVyYOUM3i7YNM7kB3iI2/bjUlPvDbWn916YAlqmkQb5IGAdeyIC7UxD3GsxO/CiakVr9EA19n1iU8J+0lNZ/cMUNg7qc97kg0sVbEkbI9RvT2+Dp9CE3IhUf16eDEA32Sojgr2jIvhbnRuYdKFeovsLAE4fZrGF7E0wNmauUCSPreOhcojRpYDns86cu17VK1X4cXV24NY+p7NgiG2OKDKTRxZCbdhb99ZSIstR4UBGGl84VuJUISkoxTXS61owZjJUOV6l14q3R8rulW1BXBS4FaTm2rbQgl8KYzlUd1aqrH39p58Kb7PxoFCUmYI983rE2Uz6VHC3NNoSEHF4s//UKTI0FDWXlbGXuuO1MmPlWMlnUgR4CDaRRMHp5Kis1mNtPhkm1BYPEFiVp/C3/Z0e3O3mGZBF62hLV9oR6Hg/U9+PSipoPaYdmOa9ViSxh1l9j+Z7MNPljX59j9ZR5b4+OXCCWqGxBjOm63ueRQG8nsrqMXK43Ma0Sr2E75/DMbT/2XuhR9B2bx21dFUVLCmHLavmyJykqmlLTWvqTJTkmSC2sJGt8TtfsyR5DLKY6wKuqFaCZ2n9+3tB3m7WhrE6h2EwFXgG+5po0Wz2Ee0NT3WdqhBP7cnIQerCosv2QOqn+l9YKyXiUCRjaaj0kgbh8s9Tw/d7j2vUUj2pDyBFG3ufVfukMr00wnybHnGE4HSSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(186003)(316002)(52536014)(8676002)(53546011)(86362001)(9686003)(5660300002)(8936002)(55016003)(110136005)(508600001)(33656002)(26005)(38070700005)(71200400001)(83380400001)(38100700002)(66556008)(76116006)(66446008)(66476007)(66946007)(64756008)(7696005)(6506007)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XZR30EiZjJxsQCX3y76xnL5zWTnp9ug2jxAD39TWzyJ8beAtdJiCbfG9FZI?=
 =?us-ascii?Q?d9kU4rte0kmlcFMmYt21Clb5EcU7NVuGPRBvNJ5xFLv9VdriQDYzUqgsKntZ?=
 =?us-ascii?Q?tPs/BB7l4OROWbqhFNcYMWmXDS8uZqUdfdEj693ep91jXG9iWYoI8FKFCLh2?=
 =?us-ascii?Q?TNrzG1BTP8agVZa9MmXIElsVy/FPF+eKkl0U/qQTJyWSRIdmPv5V+KUMYVba?=
 =?us-ascii?Q?BOonekadPosqDF+7YAfjCbcxHQLVMNPQ1iQXmQ6ZVlYKXSyKc2Goo3KfzTnN?=
 =?us-ascii?Q?cp9XwPnLRJv2jcEH1KgQAMGE2OQJ6Qxql/HvKp51OZpg3U/Rmil8V9ykqraL?=
 =?us-ascii?Q?uEManQYw3BGNRhkcmszuZAalV21pHk5Da4fQNPCMRkvYB1KxNk+9pcCajkQj?=
 =?us-ascii?Q?fQNeks9/hoEE6tzm6xdVWiSUcKJRrFHDC/AijrDibkRFECURcG0uQ4XMZ2qi?=
 =?us-ascii?Q?Z3ipBG2tgGix2Kg6jg5NF/8/5FBEpSrYImPtrwnfiop5avvunM2qB8p3KgBe?=
 =?us-ascii?Q?mY7KNn5DgOBQCTUuLII6C9PjI2tUjc5cVk+hvGf+xIMX+xQgzfxX/1Wat6tO?=
 =?us-ascii?Q?GNEr2hVc/aRdEDfMMmQ/QFoa8zoX3xBFevRT1CXsgj8WH65i76q6me9186Ow?=
 =?us-ascii?Q?lE5UKPRxJE7TEJAVYKT6twVLV9quhtl11WLKCnETqarKGw/JifUHPTc48rwI?=
 =?us-ascii?Q?Z/2qpUZsQ81WYTWAbZkifQDMaFXiRbQRQMYXHy5V2vIPldbQsiE+jwVMlwJA?=
 =?us-ascii?Q?YuepL6slf4ZqwlwnfNJ755cRmiC8j7tEpIWTl4hOymXhFbe7hpdB2xT5Z9+U?=
 =?us-ascii?Q?ee1VTkyYdC0JFoIQK5IVWMMd/Cg9MDNC9TcGkOncPUX9QJH1jmbG2p0TX1XX?=
 =?us-ascii?Q?IFgNoq9E8KFKR+WbDOjKYq/KqO0sCm+t+bBAcek9OBmREcuIIw3dlvvVXsAB?=
 =?us-ascii?Q?V3Cil68qew/ece+rxFvODH7/aW31rB9k9blLYXczp4pnlxCfe2QdPhTsHfMH?=
 =?us-ascii?Q?tb8zbSfQzHp7ZQML6fQX+siPVygtzseClqRmaXLF2DGrAHzUIgbxRa5wokcJ?=
 =?us-ascii?Q?t0g/VzKrymw0zyaUPkcypO8iQaTi6Rkv2MUoBWofkWwNMkG/LqKLpkjv28ga?=
 =?us-ascii?Q?Wpz1eGJaC863K7aD32ZqpKaUNhlOKS2yHS0F7IWcJ2g9IXxvFS2uDDupBial?=
 =?us-ascii?Q?RimN9MjO2DSuQXBGlRmoDOfElhab7NHmE6sJSqepLLsBOhhlmh0XdmGI3ABE?=
 =?us-ascii?Q?H/U7IZFmRacEmbYHS2AqGoT9i1pQ4i4NHHcP0Q1TZXtRB3f+VOM0hn65gEGQ?=
 =?us-ascii?Q?deofk84SnQCbeGmBUkMzY/Lavrz2kBamYjZV+5cobzbwQxpBUuhYCKHwQGVA?=
 =?us-ascii?Q?9WR+39AjQJpiIeWM7dAwuqJRt7cNUCt3+DQk+2bBSGUXeNz9AsoBda32TNIV?=
 =?us-ascii?Q?r40B6M3jwMQ3mmgh49JahewiFdqEoSk4i+P2Gt3gUS1BKTBnDuh6ftwEWChO?=
 =?us-ascii?Q?RHrnUxo9iQktOUQPvejQzMreJ4IEUkMNfOZe+ticCrk71iobagm1SkLYQUKi?=
 =?us-ascii?Q?l3qzUP/a3pYAg7dQBt5G0nfTZRn2oyCEIClB2Zxd469oGc3OJuP8ydhEYouR?=
 =?us-ascii?Q?BkLAh5uJfK38fstPT2Bp4GU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa6ccc4-2155-477a-c112-08d9dc804904
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:49:38.7515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh4VH7TvoLeyhY/FUeXBR/2c9m+E1SUY7RUozn1Tp7aTO3JCzmN50jLOZW2CInX+y8rsqo9YfisHr+8dVxZWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

If we change if condition, how about the division by "wait_in_micro_secs/10=
00", as the sleep time is less now. Shall we adjust it as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, January 21, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/display: adjust msleep limit in dp_wait_for=
_training_aux_rd_interval

Some architectures (e.g., ARM) have relatively low udelay limits.
On most architectures, anything longer than 2000us is not recommended.
Change the check to align with other similar checks in DC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 1f8831156bc4..aa1c67c3c386 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -202,7 +202,7 @@ void dp_wait_for_training_aux_rd_interval(
 	uint32_t wait_in_micro_secs)
 {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (wait_in_micro_secs > 16000)
+	if (wait_in_micro_secs > 1000)
 		msleep(wait_in_micro_secs/1000);
 	else
 		udelay(wait_in_micro_secs);
--=20
2.34.1
