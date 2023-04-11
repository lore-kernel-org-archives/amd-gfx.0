Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED43C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 04:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC3F10E47A;
	Tue, 11 Apr 2023 04:00:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A9E10E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 04:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiJ42DN+ybwalRFw4PE0zjrACkgyowtG9EzmyJiz7Q8iVFQDOm4yudoTgPNa96FeQnM+s69Te6U4lE3zWaj4Sg06L1bmSwdANnAUagrY2hgQggBHTjf5DVSmd6SPd1SPRW0aqbLjADowOT5GHYPC2WJtyZ1VBNtTb8RhQy7OTxtf+oaLzSn6UfSqbwZ2gFPMfcNz7jU90IlMCSobehbxXndkOSwe3AF4GNYgHul5ZoYzuQb4smOoNZ2J+e5h6UcjjTyenb4VTqlgp4lARKG8gGHLpA1ca2VIOc5y4uAUarZaSPLxLj9K3NBYh07Gj3udt6fyrSCZPdlWaPdSz0w6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fym06ylExeczZ03f50rxv5ZL1fKX3AlNJwwf45YFNk=;
 b=HFxWr8KC8g5iS2jFjjJbejmkpaBq9W5kVrZ/o3MK4WrNtuR0mLFU31UnLu5HMCiesAz4yDv6YjIZ8NSwKEZBfWkZupWyN4xPhCgH1NKUwC5GGwsxibMqO3i81YS256wCMgX+JJnC8nxNQT3yltj7RrlHU/4l07MStJchklqtdIoDZLdTp9Hmm/OMZ6s4gVfhg5fCUEd1TvBcyBKUeZTTQ1csGidDPmLW88rLput6sjZPvowIfQYO2bvHYmssjalDzaVAmTFITuo5ieUY1h1uDrJ2vEqygqgy33lAP9tFxytfDFLXIill07D05voL2YDJIt6Ltc+1U/Ik+SYRuvUsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fym06ylExeczZ03f50rxv5ZL1fKX3AlNJwwf45YFNk=;
 b=n+eALOXmBsAsXKTjhVBcVIf6OvZe1YYCv/IspNaG/10BKuaZ6CK6HZ1wIwsjwOYb4wvWqS4IMFnzDzZHOAmG0stKDf6PzujsRuUm7RghLObzPmg6DRBam8mznBy3OqfUpM+JQCx7Sf2lZJdO6pexWeEpjhwwbSuuAb37JxRGptA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 04:00:23 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 04:00:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZa6JeoCu954WACkCvpk+bIQchoK8lfO8g
Date: Tue, 11 Apr 2023 04:00:22 +0000
Message-ID: <DM5PR12MB1770C5A5A3B96879540265A5B09A9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
 <20230410114822.750-2-Stanley.Yang@amd.com>
In-Reply-To: <20230410114822.750-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T04:00:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d1d57ac7-db13-4ad0-a6f0-826c6f9c41fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T04:00:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 94e3d35c-c69b-4c9b-b217-746d91eb82e3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|SA0PR12MB7478:EE_
x-ms-office365-filtering-correlation-id: 27676522-0c2f-478f-8b1a-08db3a4146b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: viJiU4R7+EN2hgIT40Qbd7UPko8dJdZIfRQ7Ofh7oDqQmYUZeyf1iwoiJ7f2F8BqFu+AAgnw/TrHums5GwqjnPU6oPer/GE5fUe3QbKPPJ3fm657Nl8mwEmOvRfqGLu6ud+tGp7JkLozJQzHEKd0RKQaM4v/zjwWVz2t5Zlz+LAJq2979wU+MiZXceSMdvSS4JGX/qkPDr0elm63EUfuYY2iw/jBnw0New2Et2ZaDb7Dmnk07Vq8EFbhTjzF0uFA9O7jRWRL1enOJ4TdA0BUqjN0JDKNfTaCsUgTq6rCA8ehZNVkk/40IcV5D60saiiCKWHqtRqjWKOFhyhWSQDsMwWWF+P5Yh85C4BN4Dns7sh14opld05mcAcFY6HM9u+U/ymXlp8VMzBLoUbTpU/wFWwED/eg3B5ap0N6CEnwOAklMnMGXE9AaBRhNhjBAzGpvkZig4ut3CQ+ien16aL8SEPBMc6d7P2KUsfxFSPXJtXY8Y6WU2ZXII23keDSFQigi87G4NTUztzUI0afzYw/IB6QW63srxo8YUvget+ugD1SKyLei6GQ74jzubvcV/C8r8W12eyNrE2b7pRhcqgVgugIaVVbl6aaBufz235LzpySoDDcRStJAHErFsF0a4ym
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(7696005)(71200400001)(478600001)(55016003)(86362001)(33656002)(38070700005)(83380400001)(38100700002)(122000001)(2906002)(6636002)(9686003)(316002)(110136005)(6506007)(53546011)(186003)(26005)(66476007)(52536014)(8676002)(66556008)(8936002)(5660300002)(41300700001)(66446008)(64756008)(4326008)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sqfeRkW/WRLS9swNDvVyt/OaY80kbJ0pVMYnrAYhNjFtbMv+D6p0awkuRktJ?=
 =?us-ascii?Q?NBU0bqHugwkWMe0Ah9Ld5vugc0xeVYs1JvpFd2XMxT7vnofMWNExWWB3c5kH?=
 =?us-ascii?Q?9K128u67F9ZMqOUypUnCw+oe9r9zfh79PGsucNkApX0sXq9zSy1zmNWSGIwO?=
 =?us-ascii?Q?NgVUetequMAxJXjp9oQ5+jI+Je/hKw3oRYZHLnh/lxJpgOdP9Y63C3NJHwZl?=
 =?us-ascii?Q?auygvtqrJ5k9b+IHoAsBcIc+L4QuAuMko/flk+dhgOBTDz/9FbM4I7F0Jv8Z?=
 =?us-ascii?Q?U+hQxmtrogt8aFkSxi4ORmrKYPJZ9aEceE+AWpsL+EG/Fd4Qj+WouzMHbwBz?=
 =?us-ascii?Q?C8eQeSZe7GxC3j0ieuv7Q6nB513te5B3Z1alrv0/WD2efPb6r+X99I3NGTvx?=
 =?us-ascii?Q?/KyaN+DShK7qh0nrb/ZL7w6P9W2er1hb2FXizw8WfDaiCyNTAa37LPdN4VHZ?=
 =?us-ascii?Q?NtjNNCBEfhV08T2yFmw9bW8d9UZwC953XnsjqKxpGz2/pEmH03t4hVa4gKuT?=
 =?us-ascii?Q?LD05claQGGS/9Ntaa2DI80qhOiKj0Oaq6BKHBo6ngl30j4ErClAHuuh/XnNj?=
 =?us-ascii?Q?JGa20/kmmrLlL9NOwtoykelf2+xAdt9RwXFSh0fAmVtRtm0iV3+ARs/TtMOr?=
 =?us-ascii?Q?3R+MT5av0vih3dPfZvUJyuK6bMByVD0Pbvqm9KqkY/0Rwmlh90HF4EP6FmgW?=
 =?us-ascii?Q?YAk72FLQHXrGZNchSsVO/6smwgwYH/7m33rVeQGBaENoibETBu6Qt+r6eJnt?=
 =?us-ascii?Q?YOm2RmqpvmwSkXhFj4nSvHMAPQ29yxfo8NHiMsHGQGQkcT6YHpKd28USH6Fh?=
 =?us-ascii?Q?7ZhEjN1nPdaYWm6gYBpohmhU+mdZ7Szr7q7GLA9Ae59ynxe3SCyHvHbyeBNi?=
 =?us-ascii?Q?ZaoSPujc2oba758vvU76bQqKveCaIAaZWhdPLYJpIIFLw3HoE+ib14aG8gE9?=
 =?us-ascii?Q?jkfFSESJxO6YhgY06FGqksxu7DjxGMm1++3bdz6aumPXmR8uvg+ui6jUHZSO?=
 =?us-ascii?Q?vME0klvh6sWZAb/XWjiIog19thO0aC4n1I5QCnK2jBtAjfkZwuYy/L5z/WI5?=
 =?us-ascii?Q?2rIm4bjMogNpLkgDGxDmgbNyCgFcYyk4Ks5kvq1PdK5devoUPxoZ3hYBHOPt?=
 =?us-ascii?Q?nA9Aoie67geXV7J++ewtes5W4zypaVorrlJ946/opOOouDg3Hg9Be/2nsd3c?=
 =?us-ascii?Q?zSqRzrfpX5TJ76xyIVtRuvT0p0TJSt0RTldBJEHzfsc45npLhOMwcASk6wrY?=
 =?us-ascii?Q?VDyhRAehq2V5DrAsdJz6xQ/bwGk80kzP+7o2rkWCs+JJXht4rwjaFlM22wX5?=
 =?us-ascii?Q?0dN4/w0JKgAvjyuXG0Bpk8zTyKQ00quMMjnouiEYIgYHkPmODD0CW//gsAFT?=
 =?us-ascii?Q?CEfmB55UtuFYihkkH3eGXCWLU5FbxcjoVEeaTQUAtAF7cmD79nTF6m4/8OPp?=
 =?us-ascii?Q?MSFeMSFB7LczL1kRHEz/YwyUl+YLyr8MQGOYCI0Hqs2H+nh1qTBacPw2S+25?=
 =?us-ascii?Q?g8aMQI4jr9xaENW5hyJmVKEvBtuBdFEbJoN19TBFq06EsumeR6W1UlF4CT/I?=
 =?us-ascii?Q?lYPaJ2xukT6E5Ud4gBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27676522-0c2f-478f-8b1a-08db3a4146b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:00:23.6047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giczJUi5V5T+iTJWdPYsVHtDmMgCQsNoqawWGjO8FkGXg4XibazY2lORJKyfzG7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, April 10, 2023 7:48 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
>=20
> XGMI RAS should be according to the gmc xmgi supported flag and xgmi phys=
ical
> nodes number.
>=20
> Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4069bce9479f..d26a93272bf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>  			else
>  				adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
>  							1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +
> +			/*
> +			 * XGMI RAS is determined by xgmi supported flags
> +			 * and xgmi num physical nodes
> +			 */
> +			if (!adev->gmc.xgmi.supported ||
> +			    adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
> +				adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
>  		} else {
>  			dev_info(adev->dev, "SRAM ECC is not presented.\n");
>  		}
> --
> 2.17.1
