Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB89DC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C45112E72;
	Tue,  6 Feb 2024 21:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdovrsL0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7468F112E72
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DniqG51ZK66LhYWM8iFlwslC1SePPWd8WOpS56DokpR49WTVoW45DCye6bCu2MKw1It2YF3z0l0HkgOIgH4yW4/qdlxCk+WrziiUm8SAubicR26uInAMpc9CSg1WdNqUlDiPbTgDDgwMgKT8IKEugT84Tg4QtW9uocM9Q8RpT8pCNEvTwU/ZCuqfnc80Ep7lWRcS/v+jlCxxEHvrUh8tbU5Qmuf656P0lFixWt1fKIejQrxvJIXf4ayFNKMjRoxV76RIe/CcwFFj6ce9zKE4kPA8+3x0Kn/M2AxAegnJNGHTG2uZ+KVGBc13hbZJpBVATv0fudZTIbSqqO9i71Vz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBosqV0VHgODJp+OtltOFnGEhbSwi0LoLUQYEFwmYnM=;
 b=NjRFm9+gHI18cEqhT5d7YcMk/eh3zBUPvtchQa1otRD20zOLMWWY2N/O9jh/YYJVFbZDAk2sXx86O2pqAup43RaCs7cHzf2N+ePxI2QWk32BvHIIPxtyIAH3rErSYkcMilN1vn2RM9CZTvnU1+5ybryZyuCRpiwNe3vugRvzP6FF3N5Vpu6huAn+mW6pYgB681iUmg9BFEoluLhjmtrClBZgnwdbfU2D9SS3KAXdrWjRPDSUTavOvj4ojWMXnIt2dVDYO2y1+wLr/rNYRvcnPPg3rZnPV5i1dyuI6/Z17YWpF+RvwBe+V8cyjgbqOWhXJ5Whuv2lbW5GXvC64tUSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBosqV0VHgODJp+OtltOFnGEhbSwi0LoLUQYEFwmYnM=;
 b=DdovrsL0YUxVldxtq+2rqx61Kt1YP+rMN2XyREh5Fv0FKxUFFkZ2jrZbAAXypnLGHWupuNlIZzVrSYEEow8PKoDl1hqYxz5F7h0N6g8UDglaQuuPK039ng9uCyqgidCQDG6UFi8oQrFr+Qk+vwoFF15lKXQybqtwbU8UTot5baA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 6 Feb
 2024 21:31:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 21:31:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Shengyu Qu <wiagn233@outlook.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
Thread-Topic: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
Thread-Index: AQHaUsK8ygW1auIs9Uub4VJA+S6e6rDxERcrgAeMlQCAA2hYYIABHToAgAC+vrU=
Date: Tue, 6 Feb 2024 21:31:00 +0000
Message-ID: <BL1PR12MB5144A7696B8FC7FC9056505EF7462@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
 <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <8b8d9a37-111e-4c92-886d-f29da2abb527@amd.com>
 <TY3P286MB2611E17DA5FCC50F6FEC83BB987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <d180e65f-7b3e-4413-baad-e40c3bb63fce@amd.com>
 <TY3P286MB2611781B20F3953AAD2FC38E98412@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
 <TY3P286MB2611E2E82EC6DB77F1AF58EF98462@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB2611E2E82EC6DB77F1AF58EF98462@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T21:31:00.066Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4466:EE_
x-ms-office365-filtering-correlation-id: a31621d0-ae95-4429-4719-08dc275ae9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F0Mzam8qAWcrabREMJqitpKHtpiCo9IjQFhp0iWUp5qvGfRy/YxVna1S8MbfBOHznpUA/Zm2HZDdj3rGschZW6ggLrSHTZhbPh+HRQfS8uy1BdzFEzk6Ws+AnW1oGWorZ/Wny7Yke0WzUtLjKmwK5Z6Qwl3D/+7GlWtqHf6QO+XZlFpGb69a0tAe+FYBUvB4OFoOx4BqsUcNop3CTetzCZcvimqgqOI/kT7lBrNliu5FTZB5ZOm17ObzQP+K+CQftz/BiFngu5z3DH45lIiWzoodoHQknuASid6eloB3dbjMTG/OSOPI0d8MblOLs5TPuBSdG6lGwt02JVPozU2L2JrXas5WMsnKhOBlhFPymh2QVF68GPOwLbpP5C/PpnbbfQtCzjrVv+XoRY+iExqBTMdHuVYTa6qYkXKk9n6y/pw4OaFCAX97ffEpvSPDLTaH8TAnbBYsUYh6WTWedTQ98F6gpKWzj5ERjqYQR5nT5xQqu8oJJ4rcaMb00VOg04bw8MCHWkDQYwq5lLlR43gZodC4X4K6H8BUvE3bU3YE9bWOlqa5ROZmaEz8Smr0VdB64z3zBoVXVmvLoY6biSMVnkyyM8cUJPhOr7A8gYJFDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(26005)(52536014)(55016003)(45080400002)(53546011)(7696005)(6506007)(9686003)(71200400001)(19627405001)(38100700002)(166002)(122000001)(966005)(8676002)(478600001)(110136005)(5660300002)(66556008)(54906003)(64756008)(66476007)(4326008)(316002)(76116006)(66446008)(91956017)(66946007)(8936002)(2906002)(33656002)(41300700001)(38070700009)(1015004)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y2lUZCsyL294SDJEejNEK3pCOFkxU0p3dnlPdWtvQUt6RWZnV2xza0lZ?=
 =?iso-2022-jp?B?eWFEMDVJMkdCODdJZnVwdTBIS21XOVFLL3p3U0dkcmJDcDBubUFncEZF?=
 =?iso-2022-jp?B?d2xSK0lHTTdRU3lPM1JiV2o4U0tnU0FreGFPaFhVTFRMSTNHRkhGeWE5?=
 =?iso-2022-jp?B?Z3hsRUZrRG1aYmpoWWFNV2ZrTWVENG53MlhGcGpBb1FSZkVLLzJqdTNs?=
 =?iso-2022-jp?B?SWYvS2d1RmovRW10VlZSV2NiK0NVM0FqZnMxMjBFYWpaUE10cC9HVHZF?=
 =?iso-2022-jp?B?ZFZxMkQrQjR3eVA5dlB4MEdqWncxcmFscjdwNWJxbDFyOXZFS2dlcGFa?=
 =?iso-2022-jp?B?OWNFVjZHL2c5SXlvQ1FvOHJ6S1RyakVpeXdVNGFRa2VqUTl6ZXFpbENE?=
 =?iso-2022-jp?B?bGdEWnhJb1RRcE9PR245a0dGTkdmeDYxQU9hblRXMWUxRk9wZi9XcEhi?=
 =?iso-2022-jp?B?UVdLKzNvTC94NzgvOXdkTkY2UWdVd1NQMi95UThrM1U3Ny83M0pWYzhw?=
 =?iso-2022-jp?B?dnRqc0E5SVowcml0Ym9yN0xYQUR1bTFtcU42dWVpc0FBUEQ5UFh1dE1l?=
 =?iso-2022-jp?B?MWQxM3JlYjRhcHFtNWYxeE1CTEwvQ2tTOGFWRGV4OWZuTVI1bnphdWNU?=
 =?iso-2022-jp?B?MUd5ai9Gc3ZZWFllbmpuNEVNZ1JCV1BDWStjWTFCZ01HamthMWdHL011?=
 =?iso-2022-jp?B?WWs5bXNhVXpTdUxyM0NDbVY4SUoxNkxpbGloSXRiMXRSOWk1S0orekJZ?=
 =?iso-2022-jp?B?UkhraFgrTkNDZHd1QVFBMjI3S3pYSE05V3g1YlRLRCtDcU9UZi9TOEZt?=
 =?iso-2022-jp?B?aVYrNXYzNGJBVXJyeStBUlFxVnJ6NzgvY2Q5VGtwTzZUN0V1c0N6dHBl?=
 =?iso-2022-jp?B?cWo2aStvZ2duV0FkazV1SVh4UnRIcE9TYVhnOUlKZjZteERCOGhEUzVn?=
 =?iso-2022-jp?B?VzFHaEJLN3crallMS1U1NUNFK2c3SUc1VDk3TXIyTmd4T3V6cGVreDU0?=
 =?iso-2022-jp?B?YUVqRUdobjFHdEY4VWZCbEdTd1V2SWcxTkk3c1hMZ3dOb1Z6eXh3OFNx?=
 =?iso-2022-jp?B?cWxiUGE4cDd4NmYza1Vua2R5ZmVLbXJraTJ1ZzRRVlhHNXl4bmhPNCt6?=
 =?iso-2022-jp?B?bURWamhiSnZhSTZtMEVqYUNhdEdLcFRxcndSZEU5d0JCZklabktXcFdk?=
 =?iso-2022-jp?B?RVB6RXVOYjNWTU5GdmMweWloNVZBdFQ1eDBENXFsYlFISHFXTk5BSThY?=
 =?iso-2022-jp?B?ZGpjNUxWZU1zVkcyaFkwRlJ5WW1uUmh0UjNGdlNJTDJiUU9jUFRLL29m?=
 =?iso-2022-jp?B?ckdFSVNjNXBYT1RHRWVhcTFvZHpHa3hqelZFV0VJc01GYy8xYzFWWjM3?=
 =?iso-2022-jp?B?SlppMXF0RnFxUnFLdis0WjVWTnNwYmRGVlBIMG1QY2dsMDRScnVFUFNH?=
 =?iso-2022-jp?B?N0tqNGdjNEpHdU1jbFZua2hmQmVHUVJlZXhuVUN0TjN5MUh2ZUpJVzVB?=
 =?iso-2022-jp?B?T0M4MHFEaWRoSjllYUZ4cmlSbVBOTEVhUFJwNktnc1IwM0YvdiswaHRO?=
 =?iso-2022-jp?B?UmRZQ3BQQjBDRjNEZzJoSk12d295djNuY0hXWlNrZHQwZkJKUTdzZCtj?=
 =?iso-2022-jp?B?Rk12aTY2OFdSZVd4b3ViaW1uK2gvWnFWWXhTeTJUclVBR1VMY1JRL1JZ?=
 =?iso-2022-jp?B?TVQ3ODk5WXdrOHNWU2FZYkgwQTllUjhjK1MyQ1VJaTZUR3RmWUhzeGJR?=
 =?iso-2022-jp?B?alNkS0hqUzBDdWY0RHd5L0NZODJQT3NkU3p4ejd4ZEVpZ0p2WVZYS3pL?=
 =?iso-2022-jp?B?b1dhZkZnV0YyRVppWWVPblpyZDBqalNuUTlpcXA4eENBeXhkV0cvdVB6?=
 =?iso-2022-jp?B?Rk5sck4vbWd6cVVTVUt1ekRPRDkwR3pOTDRFNmNIU1N2anhmZVpvL2Y0?=
 =?iso-2022-jp?B?dk02TnB4bmJUZ1NQcVpSSitwUEcraFVOZFptMGlrVVVDMUQ4M1dnN1RV?=
 =?iso-2022-jp?B?RkZPYk9abFJCcFJSRm1GUCtkTDNhZ1h6bnpWaEtXNGV4d1htSC85bDdI?=
 =?iso-2022-jp?B?L1J4WmhsT2lXMTE4QnREeDdtMmEybS9KMDY3aHBsVUpEUHVpaTZDNXpV?=
 =?iso-2022-jp?B?M2txUmIxKzRpc0sxWkQ1T2s4ZWtzaFg5YW5VeTB5dU1rdlI1QVAzNjYv?=
 =?iso-2022-jp?B?T1p1YXVkZmxFUXlyOWtHb3A4TDAwZUkvSjRPZEU0R0IwdDVUUmFmN3NI?=
 =?iso-2022-jp?B?Vk51OGpNN0dwOERvV2w4SkUzdlI3bmNUUT0=?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A7696B8FC7FC9056505EF7462BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31621d0-ae95-4429-4719-08dc275ae9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 21:31:00.4065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VG+7Dp271r51NUwIacR1/z4md8NjxxdaytnuWhbZpQ4RLUcJnnLRRhz1gYmSFHdphklLgLS4k8aCGXpr6rq1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

--_000_BL1PR12MB5144A7696B8FC7FC9056505EF7462BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

The firmware has not been released yet, It's still undergoing regression te=
sting.

Alex


________________________________
From: Shengyu Qu
Sent: Tuesday, February 6, 2024 5:08 AM
To: Deucher, Alexander; Kuehling, Felix; amd-gfx@lists.freedesktop.org
Cc: wiagn233@outlook.com; Cornwall, Jay; Koenig, Christian; Paneer Selvam, =
Arunpravin
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)

Hi Alexander,

=1B$B:_=1B(B 2024/2/6 1:12, Deucher, Alexander =1B$B<LF;=1B(B:

Are you only seeing the problem with this patch applied or in general?  If =
you are seeing it in general, it likely related to a firmware issue that wa=
s recently fixed that will be resolved with an update CP firmware image.
Driver side changes:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/0eb6c664b780dd1b4080e04=
7ad51b100cd7840a3
https://gitlab.freedesktop.org/agd5f/linux/-/commit/40970e60070ed3d1390ec65=
e38e819f6d81b8f0c

Alex


This problem is not affected by this patch, so possible the firmware issue.=
 Where can I get the newest firmware image? Or is it already pushed to linu=
x-firmware repo?

Best regards,
Shengyu


--_000_BL1PR12MB5144A7696B8FC7FC9056505EF7462BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The firmware has not been released yet, It's still undergoing regression te=
sting.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shengyu Qu<br>
<b>Sent:</b>&nbsp;Tuesday, February 6, 2024 5:08 AM<br>
<b>To:</b>&nbsp;Deucher, Alexander; Kuehling, Felix; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b>&nbsp;wiagn233@outlook.com; Cornwall, Jay; Koenig, Christian; Pan=
eer Selvam, Arunpravin<br>
<b>Subject:</b>&nbsp;Re: drm/amdkfd: Relocate TBA/TMA to opposite side of V=
M hole (v2)
</span>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div>Hi Alexander,<br>
<br>
</div>
<div>=1B$B:_=1B(B 2024/2/6 1:12, Deucher, Alexander =1B$B<LF;=1B(B:</div>
<blockquote>
<pre><div>Are you only seeing the problem with this patch applied or in gen=
eral?  If you are seeing it in general, it likely related to a firmware iss=
ue that was recently fixed that will be resolved with an update CP firmware=
 image.=0A=
Driver side changes:=0A=
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/0eb6c664b780=
dd1b4080e047ad51b100cd7840a3" target=3D"_blank" class=3D"x_moz-txt-link-fre=
etext OWAAutoLink" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable" =
id=3D"OWAb6f856f2-3cfe-0afd-735d-611340e4ad35" data-loopstyle=3D"linkonly">=
https://gitlab.freedesktop.org/agd5f/linux/-/commit/0eb6c664b780dd1b4080e04=
7ad51b100cd7840a3</a>=0A=
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/40970e60070e=
d3d1390ec65e38e819f6d81b8f0c" target=3D"_blank" class=3D"x_moz-txt-link-fre=
etext OWAAutoLink" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable" =
id=3D"OWA6d802c7f-64d3-a06b-a89e-979e267d898e" data-loopstyle=3D"linkonly">=
https://gitlab.freedesktop.org/agd5f/linux/-/commit/40970e60070ed3d1390ec65=
e38e819f6d81b8f0c</a>=0A=
=0A=
Alex=0A=
</div></pre>
</blockquote>
This problem is not affected by this patch, so possible the firmware issue.=
 Where can I get the newest firmware image? Or is it already pushed to linu=
x-firmware repo?<br>
<br>
Best regards,<br>
Shengyu<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A7696B8FC7FC9056505EF7462BL1PR12MB5144namp_--
