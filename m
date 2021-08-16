Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9D8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 02:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B43613CF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 02:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89B43613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD928968D;
	Mon, 16 Aug 2021 02:37:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75758968D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 02:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp63sMJiGt6YPoXwQ4zK2BJ3nGuVYWOew0d/wL+9axguSH4ye9cRNQQf5sxcIYpE1/y3VFptKMhmyMIKrt3Dd0Ly4SrF1BR0ODLP+tQfU30iBKXLaGci90irFULbZDBiorjc7F/3hXXHaeP3clFRaqVeDsvXOE0KQ+cltaZXd2kmGFeh/kov9MdPF7NjQxiAOAN+goaG0zQQTSKsNu1b25smhCcRcvr284gHEyNWklIHZYTISickmY0VDLWoeIRwSgYWULzLiMEfelCJ4v9Lz7SITmxFuP/zo/n1le6h7yhA5HfTlII+IK1QgxFZ/PFYasZh2R2wclLPjwfuQ8IQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5bXL9RCrl23eowSrK3CVegktofhpo4WTyQyY2uWCrM=;
 b=j+KJfZe51EUJvoj/JTAYBGsIzzejWrj2UZCeTEY7atEfzg/bnIGJvAGy6NY6MjUx+71tUAWiLh0unBa4MevwSXyeFGAosrCRmo1clcoI9dKHy7SYkSCi9Zxxl9vPiN/YeCMw+RLrvH/VV+vzQGi2Kx03cglGFs2FsoTyIMAdlh44wDB0JnOJLDwLS9wHvzocgeteIOQGqnvTBgJfS3MiJvt65d/zHdfgCp5CpvkuQSuDhd2FBuFE1M5s+n3MocQqg2XrJJZXhWXZ6RFblHFgLxsi4HP+c98wq8m6AqeMe+pXscnDvlsA7whkUVdVqieUYmrXGOPNuuDNMt+jSVlSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5bXL9RCrl23eowSrK3CVegktofhpo4WTyQyY2uWCrM=;
 b=t+249TWkQS3EiZe8eL3A0YT7nH2SNKWFEIzUMmjmdGySd8/8nO7qplv1a/MxLFcx0neBOuKBwnVE6ZVAnKKfLY3xzz1zjkbjkvHp2gxnSCt+zbCQDtt43DheBpE8DQ39ys14bMuJj8QAzzxsPQX+jH65q+yOqGuu8Xcziwr75gs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Mon, 16 Aug 2021 02:37:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 02:37:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
Thread-Topic: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
Thread-Index: AQHXkBqXNJ2wgqeUhE6PbJm6rVHHdat1brrA
Date: Mon, 16 Aug 2021 02:37:00 +0000
Message-ID: <DM5PR12MB2469EA33529D788B3FBA23A8F1FD9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210813080933.1348241-1-evan.quan@amd.com>
In-Reply-To: <20210813080933.1348241-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-16T02:36:57Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=902ab809-4f49-4a49-a45e-932e67f02fc6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20cca378-e945-4a99-7713-08d9605eb99b
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2360A74CB6918EF14C2FA976F1FD9@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3/NYIJIb+Ki7Wz6nBED24BkHNoUOyOPyVoa/p820IoCigV2w+jX6HLZLZDbBx3tK+NtBa8Pj1zgFGfLhW/8mpPCjv0yP3ewBevPePa5t2t1Vd2wsd5rs0dOWpJC/ALtL3hEZ7jLcSkAPkdl3SQrgM1fukwqYQzuPU/B2ZqqsojQR0z5Eaesogp3qZBzm7/LuVuQ9DiO+E3MG5+QTh73WfV+IFV6EcmCyMMupC5XF1j8BzMAGVlp/kT1S9CA4FeAn9U+RjauFHT/MclnSRALPQDSPxY6EaQGFyKKRjn91ZyKaZpqKIHGF9cwRNHwbgpTzgjzuS1WN9Y2aL/YAn90jn5mw5xp8WyLC7kfR09j0tNfQj8/QRO139hvV0BP8nnuqoCWr4jr9hjA/JF0bCz5aYysHZ3ebvq7b7LnmSSv/QJnDInjAFNYPLfr41kqIc1aV+PE6I3NZA/vxQyCIn2isLD1Q+7MYGXCCq7bTaKGRQ7W45PDVy43s1GuzCDqelBTQLf5i8aCLLSTk0v2/0TTxDLsO0nNXP+9aYS4ViNxWDCMHmMuO68YiDi2TjSTsZe6XNiaDcJsL2r10HxDQmQon7e5QLlE0dxyyCoUWTocAfJniXAfPwxxxUxtsnlJmzO/qeAiPQG4I9hSjgb6imxlC8yAF/8YLdq5PbQMeCSw0hhKz13RCESES/ChfMLZiwupF2ZAUc6VXXhECDdINQgsZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(508600001)(38070700005)(26005)(8936002)(2906002)(8676002)(55016002)(9686003)(5660300002)(52536014)(86362001)(7696005)(110136005)(71200400001)(33656002)(76116006)(66946007)(66476007)(53546011)(316002)(4326008)(83380400001)(186003)(66446008)(64756008)(66556008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ha493h3Nkpl1gah3AskNJQPd1LFeIHMvDW4Sw8sS6U96Jn8aXpfhm2I+/Caq?=
 =?us-ascii?Q?n1b1CPdaNM5sDqo1s5legIG0fILNGYGNtbrYV+AYmpOuw7AANcJS1eP2A+q3?=
 =?us-ascii?Q?s00XFGxO72a13h9G68S6l2I9bstwyNEVSHAsc6yTuq12iHN+ODsAHABvP8E+?=
 =?us-ascii?Q?4Ctil45pDtLu8hoGkGQwZM4x2rDIiGbVtEoSOUK7TLqr8KOmhGcGZXajNCF5?=
 =?us-ascii?Q?G5u10lZ29pusF2onrfUkG53i1WoaO2TnDG2bDW6FNlvXTn/CmRThcvI7Vfpp?=
 =?us-ascii?Q?iEtH2+0wMmtlEikSslyccRlxvcFhJPe2XGmIiepnrIAdqU1F8l/fyoVa05ir?=
 =?us-ascii?Q?qKnY1Z8dkDu44JsP1EQYlry3Xuk8y24pR3y78Km3DG9j/sOFIo9HhQdvXf2J?=
 =?us-ascii?Q?IZ3ztieKANQ5R8Xt1SgecSWXeCD+82XVIoqs6M8aHBgo6gkl8Yqz4pzCr+/i?=
 =?us-ascii?Q?j7f/XS0NX6w1+f99BzsPufOBGReHTaTctBQfXE3Ulj5wKDIBxrR0GZ4/yraH?=
 =?us-ascii?Q?zV2MFwpAoMtBhEDudKuiFc+wUfDKJcVHx1PqmAa8L1VgZhGF79c/l+o1TXjz?=
 =?us-ascii?Q?m7LvaDxDzwid5oyxrsMR+495OLFp9KsvbgMceWp+fr9maZC1jeiSNvGXl2IH?=
 =?us-ascii?Q?hoWD8VatXZAoWakzBtmSznKFYHCmgh8RjwVuvxgr5N8JEm7GL8i3/eMrYjPk?=
 =?us-ascii?Q?FJOYz5T11mIA5GW9Hn+gBWWBFCUdb1dQCNOqh3y0/+8BoETrCNYNx1bbUQGl?=
 =?us-ascii?Q?m6boEzxcdNoxSQftGNilFgB5BHgVXbkRJ9eDrl9E4F/51TwpKhRT/lSuntXQ?=
 =?us-ascii?Q?5N7PE8jBpzxwIDmvKAxRMbC/rEh33aahcF//O1jCjCUzRFU30SZGa63J08VZ?=
 =?us-ascii?Q?j6+EpIDR6c4RZQ4TGgCG0MUYqY+V8dPbrfdRl5C11LRgrwSXK6nNpKwh4FLO?=
 =?us-ascii?Q?UuLcsmxHXyTSDK5F6GdeYxpnAXGJ25oo0QZLgbfWVlmlKRAnRXDrYrsz/gOS?=
 =?us-ascii?Q?bZrQrxsPprJnY9Wj2nVa4ywQ0rzdNu7Ao11C9UVM7ZIE1PzIxj/Iw65QqzHl?=
 =?us-ascii?Q?r7XgRXz6pucAZ5pwPSXBnto6VJeW+plteQOR0v4jSy7uftvPLHpcWsZpKkRE?=
 =?us-ascii?Q?RSoU9Q4J6e885yFAAu1cig0psq3YuFdqHLKSC8WrjO0Zwrprka9XGMIUPdBc?=
 =?us-ascii?Q?EeyqSWrLmoQeFdg2EMO29mY5FyuFgbqQ36n7cC8SqU4z/BazugS7YKMW+b7l?=
 =?us-ascii?Q?X0Hbq1yI9lNXgC780mhY55BaQC/5wVRpFAMspFzM6j6Yt4k8geTnUCplCOVC?=
 =?us-ascii?Q?NfJ5s7FCZyZryrRvBIZ2x6VK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cca378-e945-4a99-7713-08d9605eb99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 02:37:00.5732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4C5SAtKb3vya0ckZERgplz0LuELVqvNlUjAR74uAhJEU6HecbMgJDloUO8CsnqVT2qX4QqL17pETeKkrc7nyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Friday, August 13, 2021 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU=
 temporarily

We have a S3 issue on that SKU with BACO enabled. Will bring back this when=
 that root caused.

Change-Id: I56d4830e6275e20a415808896eecbadfe944070b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index fe9a7cc8d9eb..7210f80815b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,7 +904,12 @@ static bool vi_asic_supports_baco(struct amdgpu_device=
 *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		return amdgpu_dpm_is_baco_supported(adev);
+		/* Disable BACO support for the specific polaris12 SKU temporarily */
+		if ((adev->pdev->device =3D=3D 0x699F) &&
+		    (adev->pdev->revision =3D=3D 0xC7))
+			return false;
+		else
+			return amdgpu_dpm_is_baco_supported(adev);
 	default:
 		return false;
 	}
--
2.29.0
