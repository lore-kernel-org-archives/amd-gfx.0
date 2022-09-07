Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A57ECAAD5
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 01:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5280810E00B;
	Wed,  7 Sep 2022 01:54:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A8E10E00B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 01:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/xW6UT0wzv78PHcki2gfunduE9Fhfn4t351LJLTFxjerS7tFN73/yIwJcbDHtyp8KOhkTHcmtdA036aeYPadIUjQpaSJ3ZPZeHE4hmAS7E+N9W08UThj9GrSx8TGvdWw6kQoVRhympjoK/eZEy55w+T15mkluwneXQGig0MV2u7Gsz5+oqhiZTFGAykYaEAcgD8WqrEQvJJGU5qB0z/RPFawYomG0c3V9QCyxHA2QjP/CsYW3635atpoXaFL4+DMlMHahJBXC5nUHuyHMNDKh3/EiUq7DXrpEtNmms0QwhnsSJYS/oKAzsYO1yVqWaLruqGQdc8gAbEURgKsD5F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbXOuvFOqIpPEBLGdygaEPAJZaWXNVhwPWSl7sMJ3nc=;
 b=M9EnCmllxkdVEDME7zAE/Bh2yDPtb4vlNdYzz5CH0Ymp9pC6R7lKFVsbObNmvxZdtNuGDK/aDnScaerwOGfc1GywIXPSXg6lrzXOiu7RsfZyD4WYCLNwXIaOjeYhduGKTy2yhLuUujvOtfe++MDIg6lXCiCnmxqTcJ3zby3GK4DiMK46cdPR8eMgGGQkiZl9VqKNumCyRtlKPQISLBQa0YoXClgJ+D6MPqVMrWFH8D+0cB2QP8gPRylNtQTKRYwiA3LF9534Oyk6xrOvdFQWxqTvreVx4pXnL3U8D5BQxykC8cGf1jpVVl69+0MJBILEjWxfI3EAb61AiPoHHHLgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbXOuvFOqIpPEBLGdygaEPAJZaWXNVhwPWSl7sMJ3nc=;
 b=TY8/mE4QImlsdDI/4QrSxMPAY7pGhd97KuviAHaqqwO/I5G9B0mXPvzmeTghPIumP3lC5BcZTg8KQxIOBF4eaJnIXC1plMC/a4CAD3oIbtF1d9ZM/1kW9nuWnn4l9uULHEDw0ZHCvWV0nVM/X5DfUf54W0f837CVmJHwZ1Ou8kM=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 01:54:12 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::7cef:6825:32c:aeb2]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::7cef:6825:32c:aeb2%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 01:54:11 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct doorbell range/size value for
 CSDMA_DOORBELL_RANGE
Thread-Topic: [PATCH] drm/amdgpu: correct doorbell range/size value for
 CSDMA_DOORBELL_RANGE
Thread-Index: AQHYwbPnJGv/hhkM/U6NNfO/kPbwdK3TNfqg
Date: Wed, 7 Sep 2022 01:54:11 +0000
Message-ID: <DM4PR12MB51365D812AA28AC51D1C7B94F1419@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20220906054522.67936-1-yifan1.zhang@amd.com>
In-Reply-To: <20220906054522.67936-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-07T01:54:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b8b2f2f5-60bf-4384-b7ec-dbb001624c64;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-07T01:54:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8ceb5e01-110a-4e56-995c-d3300005ee34
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b57fc3d-1cf7-4e2a-477d-08da9073dc5d
x-ms-traffictypediagnostic: BY5PR12MB4870:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCMmsWaocaGBzD59iUXJ+LjCjIc8yu8KmlR69SoJmYjgpj3qJz0MlJ4r4fqFhiub/9HCpBA30tHlgDUGIqTWrZv1SskxZ3rrC7a4yoQIQ+N+R03d70vQMC5/UskzpEYUFNd7PHFQ3T1frvwSVavBwYU+XjfS/+7jikgdXSZFe+RdvKXGY28Z2rtJ5+xpB/aKZlipOj9mvfMq3YlnwXweV92+7bBRKBRw1f/e6gL3+dMRyoa6ZrSZowxhaARmQDUB5k9pXv96H8n5lvHLlu4pntJSSw5dI/rfxF2vBY+gLhOFXnegSyQrDgiBWjjRUGCMOeqVGmalUw4TIzSrDBc2dscSgg+W+7S2eypcuV6rLFgDCzhFH93BoEcoNo6eTbZ7TkWJL6sq3jF7dyG6IF/FlmB2SzDWF2RXfeg646Wo8+lRzFrlsyTYtcHprP1R7fc6L75qsXnPVZ1fLMx0k7rG+Sd/aNsG6+ZvdFpKSbOicplvGFRkRIub1UYTjLGRCW2C61wex/p8yT2egYer8aRwYqjK4mPTH2ohNg4YOLsnfYeCWfdbbwQgX862/Rekzn/qg905vMEzXExSEyTlCHvppTmgbTzGka1QrUh6426MsaVSFfuvZsZSPeu9u642chp/88t5GqrnWZz2S2jnW2Ie1y6vCCCLW0qzadjTY9pd9LuEXFml3kusmdxiVSssE3+MLyWEMoGgRjVdmApv8SsJoL7iSg9dTSy7jX6Bd7Lgl3qsSWZjHLqGEpgLPOorWZFxsTyLxjt/ENRf4iqAqFMfAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(9686003)(26005)(86362001)(71200400001)(478600001)(53546011)(7696005)(6506007)(41300700001)(55016003)(186003)(122000001)(38070700005)(38100700002)(83380400001)(33656002)(5660300002)(2906002)(110136005)(76116006)(8936002)(8676002)(54906003)(52536014)(66946007)(316002)(64756008)(66446008)(66476007)(66556008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B0/XQ9VxwXZ5EZPXlcTzCAsWniH9iZoLlvwCmx1UWYrKUGvQCJXrlaRttZum?=
 =?us-ascii?Q?gnYXioy8GrCAFlWm+4pQ8i1dgKJ94KCN9jKWlYocUl7Cj+KmOzxVwfvTxRzP?=
 =?us-ascii?Q?Khpcdy4LoCW5mknD/54CXx0UzokhjogSEimneLkPNHuk9H27YGZokNOrQCXK?=
 =?us-ascii?Q?hnlbhxepcxF52cAefbG7TpB3A0GJBs1tx+i9CO4ezACgd0EaupFrFqyiGR4+?=
 =?us-ascii?Q?0oNAOw/dxCefkjuuWqg1uB2FNJQrCQ22OmST5t3588Mf5NVlx3wwZ6lcZJg+?=
 =?us-ascii?Q?iPFOZAjqqMhN5h+wYPP5d7Fnt0pjgjVxCCbr4sau47HbirhgpeSRgN3VNffO?=
 =?us-ascii?Q?b6Uy63AzwwKusrgbtfC64EZLNvJVV9DUooeUaoUPP77v8W5AuSbdYg/IRtZy?=
 =?us-ascii?Q?KRG0JR9Mb+F7xbdT/DIp4HQ7TLuHW2tyRzcwZueB3DIqcwnDylrIzqI0ya8d?=
 =?us-ascii?Q?euEK5IZoQxKj5UkfoffQngQaSE0ZlF8VU26FpAtx0NKRt8tsJyR79VDR2IsK?=
 =?us-ascii?Q?yUg/iAsuv1X+FnHblN3WiGIp1ON3TWktU4o5NaTSFynYx1DUJCaqZrfsCMj0?=
 =?us-ascii?Q?iH0S2hJTBk2+lC+NQo2+JOUld+IKnNYvtEcnDebecwX/7vdAalJdigh0snSS?=
 =?us-ascii?Q?CoaPzil6arfIKm6+UGtx0hgqrkm94VXMSuz1rSg1aqXE/tYs0+ZtJ/UJaEH/?=
 =?us-ascii?Q?SXzLxPTvfn/wV96lmavE05US8wch/UW/xaL8n/uEaKelePLM1FqzkxLW+TcZ?=
 =?us-ascii?Q?/a++v85dGHCqK9XZYnKD6C06sF5txIA7U3T5ZyB8C0PHwZF0TeJbiewBsOAx?=
 =?us-ascii?Q?46+1ICGU0nrq9wqBHQNTTDjKG/gf9yRLcN4T7Lo2P5xxnV+SOPGiunuiwPo0?=
 =?us-ascii?Q?eYqzMMZN2FW83+qC5NR2435Q7o8V5BhV7WSJKMhGBDzhznnVAy9RSQSt4MJW?=
 =?us-ascii?Q?caxSmOQ8IIyunNGoJQ935iuRirDtu/qlzO3PHnoRBVPFQE26JauAHMS+v2WS?=
 =?us-ascii?Q?dJ3YDdfbs4QilHALjJZuefgFUDQfqPNSZSiqDuOsgVR1t7+lF+Ru6BPF1rbL?=
 =?us-ascii?Q?DoiAsYisfcJ0rzV9Ifv24ZfrxYfhi0FzDBGzBema+sSir2Usbg7mbogBWeEx?=
 =?us-ascii?Q?74RjtL3zEjYj7mfhpy9Ha3GtNsM4ppijTFJo929qDNncfgpJs+68V2B3HVog?=
 =?us-ascii?Q?ejoHJMb58ghRZqDFskJ29fSNzroX5G7qC/UTZ9NBQlbE38HU4qQdirJlZfYf?=
 =?us-ascii?Q?xg+wsj0FivGvTOfUZ04Z08m1vF3SQdYMRjUR7pG80POANxA+CsSd+ZCfyR6s?=
 =?us-ascii?Q?Ew6eWdqbIC61aG79p53AkrxMg8FMvLxzP78YhnxgJKcH/GQH0x4bzjB99pk9?=
 =?us-ascii?Q?+nj40h2ZgsIwdQZKsf6nGeUgrXnjFByyo84L8/yy89Ec2OXhpCohF5P8QWbY?=
 =?us-ascii?Q?29torOtT9e5yOCmLbSys823hdQTjjIHDLMKkRr65WnQoRv94z68iArAw+IsT?=
 =?us-ascii?Q?EPnFAfTLjni2Fqm7XdWh9R343824rcZw4qcefNj4/jZ9zd4awfNNWKf+OLba?=
 =?us-ascii?Q?fF2KKdOrCMdSuewUXH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b57fc3d-1cf7-4e2a-477d-08da9073dc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 01:54:11.8930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh6LvqDEODJ3I5nw9Rr0jMTvM4bCC7XFIAjuWHI89Ynyj4cgwnDSvsNWATZsDXS5LVISpKKTnpNpRx6xuPKPyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Xiaojian Du <Xiaojian.Du@amd.com>=20

Thanks,
Xiaojian

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Tuesday, September 6, 2022 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: correct doorbell range/size value for CSDMA_DO=
ORBELL_RANGE

current function mixes CSDMA_DOORBELL_RANGE and SDMA0_DOORBELL_RANGE range/=
size manipulation, while these 2 registers have difference size field mask.=
 Remove range/size manipulation for SDMA0_DOORBELL_RANGE.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index 1dc95ef21da6..f30bc826a878 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -68,12 +68,6 @@ static void nbio_v7_7_sdma_doorbell_range(struct amdgpu_=
device *adev, int instan
 		doorbell_range =3D REG_SET_FIELD(doorbell_range,
 					       GDC0_BIF_CSDMA_DOORBELL_RANGE,
 					       SIZE, doorbell_size);
-		doorbell_range =3D REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
-					       OFFSET, doorbell_index);
-		doorbell_range =3D REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
-					       SIZE, doorbell_size);
 	} else {
 		doorbell_range =3D REG_SET_FIELD(doorbell_range,
 					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
--
2.37.1
