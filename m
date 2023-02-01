Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5757DC636D7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Feb 2023 03:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F02110E084;
	Wed,  1 Feb 2023 03:41:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1D410E084
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Feb 2023 03:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQs+UaTcP9CFjId/8zKJHZ29+rWwV4GXSym1Q/M43NB5+ObyVt/uOF2oyvWcC3NyWmyXiOME4CwjwCemxyFRsh48tpep58SzLcsenLFnf9Pzoy8iV0FRKoo3tz9SI7QQM6LIaSe4jbus6M8Bfk5wCOgUBaP/itLjR3uApfZbs7eUqtyOpENmx0Gz9OOFjK5EvcX92KP+JWX9Q7O+jxGmPX9K7gQuIEiRQV9dpGzXmTihR2rNCgJ9J7P+M/HYx3xgtzTlaiA8fAbua+QWYMA5Trs3wKDEZLyMubYWErdYuvQD2AYfwQdw9H1kFfzoMdnIWXCU70pmw1o5VJLdPbfupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoCPvJulvGpAo/zhm8vyoQ4FYGNo2B6YuKAOj5jp6Lc=;
 b=eH+dQa+CUMMzkEOtxl9Hevb0+QAoF6oQAQjkpUHUo51jhMr1iq5zzkar2LLM57pPdzdYl7Ld3jRUdhX8OrzYO7q1NiaesU2SOmUNt4jdZK9gXhZ/edIB2PMNKCe4vKKhJcaXYCYq+CsazBbtuGAUfDZR+nTlltFK7vHLPekt1Qg0rnVmN5g0+FmQRzfRmbJqofpPoL7QGNSSGxeD3UQyFDJ7gTrlb03VWvzTN626+Mr7aXumAkpzkeEQXNtsvHARNdrvPiMZmtjtLrUruoZWcvYXzdnPnXwkMbO2lqJauFCYP02skAQK1zq0Y7ggLWMCcc1IFHRyYila79xgCI0hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoCPvJulvGpAo/zhm8vyoQ4FYGNo2B6YuKAOj5jp6Lc=;
 b=F4zWDqHB1mUU+LRBsXZ3ong0OBdZTDgzaevMEmx7gvuqzKsOB5xslEryUGM2bfSQmTvgBweHnd5raBOU5QI/3hlR6WOyByqttRZFkE01GSZC0oQ+TfzjSlgbNxFx6KeR/nM9Pu5xBhViIeR3JocBJ1cu+7xrdQp50lT/gZ6KFdk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Wed, 1 Feb
 2023 03:41:11 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d2b7:7f24:a2b1:5ece%7]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 03:41:11 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] Revert "drm/amd/display: disable S/G display on DCN
 3.1.4"
Thread-Topic: [PATCH 5/5] Revert "drm/amd/display: disable S/G display on DCN
 3.1.4"
Thread-Index: AQHZNZ/L73N4DGxmy0uFfoxc3uvmkK65coqQ
Date: Wed, 1 Feb 2023 03:41:11 +0000
Message-ID: <CY5PR12MB636996976CFB37323C72ED69C1D19@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
 <20230131181326.3507396-5-alexander.deucher@amd.com>
In-Reply-To: <20230131181326.3507396-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-01T03:41:08Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bf78ef32-b419-487f-922c-e14dfa9baf63;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-01T03:41:08Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 885bf8e5-a07f-476c-81b1-8343dfc7157e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: fce085eb-3f8f-4af9-62e6-08db04062984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zu7xukXlHnmA4H0aq+Lxq421+afQDK8lSpHQ79VdkPRVkAQrXubcryFXrIrCxjLvLDWtgZ2FqD/RmuobbKvCfooapdZWSVTx3cFp7WLU3Q5WTfdoQbqxDDVeguFWb1AtnQkobS0eV6sNGECfVp9sPO0GWR11FLjjahqC9ZGOW5OrsTeN2dZqYeCbUq6Yw4yMa/P/YbCvPF5PpbaIZHA4UCBMbyb/WrempYmhrgNtnBIgQ/OclBGXraz76cLWHPYZqgfmefqZses7Aq9r4OTcYjl5VPGn8q02bpzNTKL7UDBGW4ySeFoc0ugSSLKqphJ9mpK+kLkpsgvVSNmyAvPX0JFpE9gjXfGz7sKhcIui9jElx1qNS0OS45yMvdyd6zxylhaK40VFCwcdQmi4K/L7irj5ObgKogMQpH3RupZMuc6WFAymPY9k2GdLAD6ZLWc6op8T2p495UqcAPQAv5FKVvJLW6bWJik9SCmzskWaOx/1XxodiYnrlTqyVBLcQ7ZQOHVFS4YIakqt9+g1aG21qEejYcZhnH0bP8aSk1jEhT1G9trl7eodbxlb5uiKJVJSU9pjp46M3oG+FV3Ykrhqkkt8l0TtJIN8PKcTPRkvCbxVIyMZxcZUkPNbHstDmwl+3TUDxNX9jN5ipfvCz9lB62NMMtVobd+DatleJufsawao27xeyb8il31SUBLGNmKy7ASpuDVF/fVQTWnU7jxfazrvLI8xvd/V+SXBafM74Lyl/+CXdTVPFdPyycxkJsbU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(38100700002)(478600001)(33656002)(110136005)(316002)(8676002)(41300700001)(52536014)(122000001)(64756008)(76116006)(4326008)(55016003)(8936002)(66556008)(66946007)(86362001)(38070700005)(66446008)(66476007)(6506007)(26005)(9686003)(71200400001)(186003)(53546011)(5660300002)(7696005)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NApwcFmPgE3lTNUjv5dDczUec9boe45SM/dpxT8o9ex4RPXqctUwYllfDMv/?=
 =?us-ascii?Q?jkn5VF4Cp+1tuN0sN6f/ZaZ0FvFxmQg4gnM68yAXJUmFLpIBAtNiPv7P7eKT?=
 =?us-ascii?Q?HAlkgLX6hx9VckiThjr3lMjF7PdULDLzxZOsxEmcp/jWIm4irNfSsNOQ7//x?=
 =?us-ascii?Q?NOKfmgTJidDIw50sL0lFqRpyAnylVl6M6msPZZZFPnHMHcNSRBFSP1aAJXan?=
 =?us-ascii?Q?Sp7bsPMlqTYC34OOfUTISTR5Jpc9ARsYsgunYZlfgyyKmD3padnPlrXW7Fzw?=
 =?us-ascii?Q?00Eng8ad/LQ+vuhiya5w63NYtMwEScoQYl2tspCt/P8iRE4/n7hYxErMD7nZ?=
 =?us-ascii?Q?wmrnXg0y2TL+A5+aBLJTuifFh6ik3+izAIvXP2RVrePFO/mINPNbq3pNdbmW?=
 =?us-ascii?Q?h34LnhQ6vwYzDHMAItUPX4yqZbmUuogZWbE7eljieg8J6r5/UZAR7rto2wRY?=
 =?us-ascii?Q?y48jvcK5o39/HfYXos9kudFJwPaCn+M4QsN2g97x7z39XcLOXfOEqzkjdwWF?=
 =?us-ascii?Q?805i0CbXpt/KqUFQjZY7l3NG27w/AqAEg3JaGI+GsbZU4+zpFziU9Si8WOPS?=
 =?us-ascii?Q?fGooxJj+EVlJnin3/naeVH0/tPYDUs1M2wSVQCRbqTJukyaxi7JR3pmB+V9Z?=
 =?us-ascii?Q?7LZEB2dmp3XyslLo4nihgyNQhaM7aNS0BJ/WGULZXazwuSaoIFBCAe/xIEfG?=
 =?us-ascii?Q?595Sm4wVQZOI0hDkVEVj1vPajEtcwcsdmw6d8C7rr0otUKGJSVzh9aMz9xgw?=
 =?us-ascii?Q?z9BIX0hMuUNrnCRqB9nf/1Fcjtn1jEzSqqBr1x2/EpVC1X/SQIXszyxYRFQN?=
 =?us-ascii?Q?LndHIe9vrDK9AoszuEob6mOTChD4oNs642HdEc2hFUAHnHbWBCNgypH3LdYc?=
 =?us-ascii?Q?2O1eFY1bS8jf5yyOCZ3qZbv48vPZy0PLn3LiuL0W4uz7r6JuShsmFLiRJrOH?=
 =?us-ascii?Q?7p7UGSweVmqWb2D4MaD8g19pu5YgTOiistdgDKJh3oDZv2HxPApcjeP4bsTd?=
 =?us-ascii?Q?M6drcMg8eU1pQnSpl1fE5oT+kqgSGfweWREzSJRFz9Nw1rx6KE3rY6Yp8Lkd?=
 =?us-ascii?Q?oNR69vWvyv/7MAgHxx0TrHFNpY+JnjmT5OqN+Or2vuA6tz+3yAjF+Rm4oH3M?=
 =?us-ascii?Q?ejtoSjPvYQf87nlMi0/tDJu+8amnyb5at9SfKKtzzJ7wKLvztSIVAgdsCB6b?=
 =?us-ascii?Q?FsO/j1RN/ptQX3INwM5bWsm8QDV0mkzZMJxlq3udowcb6yskRX+ma6mCI5jo?=
 =?us-ascii?Q?XQa+QHIlrePB3x3vutjNsBSDKLrEN+/Sh40Sli1nJgWNn4hoV9nlfC0e+MCt?=
 =?us-ascii?Q?zhC2MwhrFYf5OaOXyyY2xodJbFUbvoOkuV8uffJDv3KyPR28QpDeXTIcj/Y6?=
 =?us-ascii?Q?CrUSsBkK9LdsNzsRtVYAW8jlOVFphDkqyaMac4camvZyVZ3dTOHMyTIB5BLU?=
 =?us-ascii?Q?zRkgUUyLEHRJMbholnHyh/FkyOk2Smza1wjCsZqElLal2oHj8l0mNCR5l4Fr?=
 =?us-ascii?Q?MDFzLz06pn+HAMSwvzsh/EYVYThhVSiPM4+DJ1CYrsK1a9bRSImiDHYe4Mum?=
 =?us-ascii?Q?kMZObAMdI+NzsLhpFBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce085eb-3f8f-4af9-62e6-08db04062984
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 03:41:11.5601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEFTveXNmUHIFGBrAhFJP8KuZJ4rNNrOqusdr12qEbMBKDdgxhjYC4vErBMdwVwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, February 1, 2023 2:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 5/5] Revert "drm/amd/display: disable S/G display on DCN 3.=
1.4"

This reverts commit 9aa15370819294beb7eb67c9dcbf654d79ff8790.

This is fixed now so we can re-enable S/G display on DCN 3.1.4.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1f5b9c485dda..3f3b24a22567 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1549,6 +1549,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 				init_data.flags.gpu_vm_support =3D true;
 			break;
 		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support =3D true;
 			break;
--
2.39.1
