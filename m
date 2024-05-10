Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA840C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C92A10E317;
	Fri, 10 May 2024 06:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ez2Utqyo";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FFC10E317
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/AfwHVo3ujeu8oHOLTubiH2HoalDLkZpRLrWdhmibPn5AWwXEp13kfpERgblz7W2uEfYsCjpXdTA1QTTElmM8FvDva6VlwW+Ij1il8E8/r9xvkaRpu/bBlnIX3p0wTgPQIcceWoYE95Jp02fnU9Qs+EUyGAiii4t9Jxh+xmubVWNNN6wpdEts87VT+Y4Y2ly3wp2yq96bH4wA/neuWVxAgAlwN2hmhrvQNG/RWFVzFhuioxXcIbkyABbxxuCJdrASirrwQRm4GNev3cKmuec8ojsTWrBccU0Z877p3PP9VXZEwCsbjd+Y2BibSzN3IWfnZghsb+MS/YmI5bwYansw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU7BODoxai3kqdvRm6i3MCJa2jLqI8IDUuVmKshlxC4=;
 b=WoZQLSVvfIxOjB0GWw71uGf/jP3t1wHdrufYk2hl8rgmx87SyFgh487iIuNnV4tyj9KG/shdPLHpAkcBDlZ+zbu98zs2llJSJytGIp5SmWiz4rSbj9JDtYwjnFPtEsY4y3iq2pI6PqQL2Zl4bQjBJUKxyLGmNsqc64wrjCyy1eYA9nH35ocF7N9Bbjk88dX26x1Ji0quUO9kutZRVTHVE+XbiEx/6J2w82DcUfsshTfsU1GeuRsfV6UXLEoIMtOK4J0sx+WxzGs8/aDbB4QqDL42JcqI7pFOffsvSKzWTADksQa/wR40GloE1mCVYIJlsLQmRSpD9FaMk3CZHr9Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU7BODoxai3kqdvRm6i3MCJa2jLqI8IDUuVmKshlxC4=;
 b=Ez2UtqyodP2H/UCXmi9zNJDKcRKr96JiJeUg7cf0TKYo+P4oSOXNKdajeHWfPfupc+t2jPGOG/ACPABoLhGzMWV4gP1GwG4Xvrz7EDmMY3QFO7hBGFL4dfh8ZBAuVKWfBXI8rE9VVszKUxYRyNhByayXPyPZ/NrBUCS5KkdD3kI=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:38:09 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:38:09 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 10/22] drm/amdgpu: remove structurally dead code
Thread-Topic: [PATCH 10/22] drm/amdgpu: remove structurally dead code
Thread-Index: AQHaooU3fgrV1SO02k+1st2RL/O4grGP+DVA
Date: Fri, 10 May 2024 06:38:09 +0000
Message-ID: <CH3PR12MB8074A81C80CD19941C5BDE7AF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-10-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-10-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=61f5691b-1308-4f5b-9be0-95adfcf9adb1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:55:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: 131cc87c-7d3a-492d-8810-08dc70bbc231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ywwSeXJazn7SrapjKXQnHp+mZFF0k0wsV73+rbQqZRxvkG4s4bvXaMjh//?=
 =?iso-8859-1?Q?TGALV5k2Ju/QhER+x8wLlWrQTtuFnh/sYUECU1xAvcMYTY6j5tBJoWLk/g?=
 =?iso-8859-1?Q?1wqwMjJI3beq+xmh1SyHvt2JwvrKXxmaupGuC2N0SuCMriTQIAoC+WiHVf?=
 =?iso-8859-1?Q?YsXeyf3HBuPcADl03xDRTb5N8Djps0L0Mx/17CWDBUL2bsUC6U+/zE760Q?=
 =?iso-8859-1?Q?ucIPtZbG8ndJfphDy5UHxywsMojahHPsdeJEiY1yPC999S9kzvuC98d9/G?=
 =?iso-8859-1?Q?EoIheKlubkB3PnrFaXqQVUa1+CYo1uSgysRcu2rMkVtF2PksS3J/jbW3IR?=
 =?iso-8859-1?Q?2LvWLsk7xvL0d40+gNWdJqffTNCIPIULCWZ0UW3n8F5f5wVf7YaVswIOen?=
 =?iso-8859-1?Q?aDeLEhX7xr/NEel2BN/ObPxGV0CSo8j+cdT+Z74/Nr+1WxVeID3yVAYGnr?=
 =?iso-8859-1?Q?6wcb2YibeHm/pXztIXnJ9L2T0BjmB3ElwaA0R2CTB8cjHDyikFt9ZoD0+X?=
 =?iso-8859-1?Q?gtdqcyNKjaYcS14qM85VTb8XfTXXrhkYvaWezJUGReoxSZrc8WOHZ7N2RR?=
 =?iso-8859-1?Q?t+8NwzZYa4wJzibkZk/KvrKz8bqi+gMhXKb3ux0zwASw0XN6OtPkBPqIJp?=
 =?iso-8859-1?Q?plFIub4V32uTibQrcMvic6WStFY6s5WQez1gp+amAduP9yFnl7v49+kEMq?=
 =?iso-8859-1?Q?z/AFQjjprZG7wVTS/w13ttVstVDWcUM2lykIgrwVgEnKAmE+P9E76JHzgv?=
 =?iso-8859-1?Q?C8eFyXV3QaWUyH4CQiNRWgdP47CecSuzrfux++a+DCWZM/pCx7JSogiEer?=
 =?iso-8859-1?Q?6GsRDr4myahJAGyoH/ema2gNXo1rYWI59Y7td5LD0P+trVUzGd3wn1lvTY?=
 =?iso-8859-1?Q?eHAb/cK4qlGWwEM4wqXpD9bmzUv69y+8wTfd1F5hOtZUSlDOuP650eFPiJ?=
 =?iso-8859-1?Q?iPi0z/qe9cxCFVa7wlOU3lFOXaqn00Rw6zlhMgOBXvHVIpGpJQFuJZykU5?=
 =?iso-8859-1?Q?Ata8tDlpNU3lYMZ7IRtmZOylUCDCREt6xu6Yn/3Eve8AslQrhnzBtoAk9I?=
 =?iso-8859-1?Q?6gRs+9EWYaumKRoZp+4O4D9fvQHM3HdF2PiI2TzA31Bd35U96/q8QnT2Et?=
 =?iso-8859-1?Q?rrtCyBHUXo9pK5RBK0pw/+J1ZtrkloP5pMC+L/FXyL+9GHz/+iYbMvl1R0?=
 =?iso-8859-1?Q?MPcot33OiAZT1+4b1rU/ry4KIKd5X5IPNSuIDRhRwyhkRdJ8ItYjfjsk4s?=
 =?iso-8859-1?Q?DcTsQ3ojD7pAqV+1nBQTantkr7RyTvr7z6byx+QN4CvpA9hJCR5bYEbqv3?=
 =?iso-8859-1?Q?AimrYs/zT1gXXd1aKcU7HVpmkHe3eJOQvzkZHFu3xM+dY1recyEd98PZZs?=
 =?iso-8859-1?Q?rl8bCFVz0dx0Z3gwT3UqlIiBFzmcS1dQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cz8DrZSerk6KkYdZ1n6yI8iwljWQw16zVFJBTHp+ux2XsWP9hffpsz/14U?=
 =?iso-8859-1?Q?lFNOgYoA8kLA/251i96e89D5AtZ/qChkc4y4V7luqNFkY2sp2ilr9tP/SG?=
 =?iso-8859-1?Q?07FSQMhtGlqOf0hAo3AzDTOIsvwVeIA5QBjnSFkExgkEGNdqrG77BRLmwD?=
 =?iso-8859-1?Q?d+4JAgh0ue2vyAxXo+jJsQ7eF6inGf+UOjFQlRvp4mdbYqGQRxsEq9GX/U?=
 =?iso-8859-1?Q?NlWxPGWCROjZmkMe5wc7L6ycHxRmbL6lp/rqiaEHpPdfVCMcn762Pwpwh9?=
 =?iso-8859-1?Q?/TXjWxGJ53wVXxP4kTRo23KIa8LIKorXerUAjRiTVdBI5cnT9yGNbPOuCK?=
 =?iso-8859-1?Q?1W/DTvFF3I95DWhK6wInHfXqcQLNyykHrQg7agv7R/lS2QBRNeNcrp999P?=
 =?iso-8859-1?Q?5XYE9UmTSUPg+bu5x9om3Bluz/N7NVvsd61lckV+yBDdQLKkg5Ffg0xQ2X?=
 =?iso-8859-1?Q?qZDiTy6qAA+w4d8EYKz7jy+s/jYW9ZsPhOZwC6BAuqpHw4jPoTyB38LlDj?=
 =?iso-8859-1?Q?adM491Qk1BmUfUjrvXO0ZD+BpYrdPM8QTCJobZBHlTCp2vsNcSgNrr2CjW?=
 =?iso-8859-1?Q?H8Bx0JkjZFc/kCE2QPJUJCmissz9vKYXNotfIT9wHtQJAxccG17Of+s4te?=
 =?iso-8859-1?Q?OPWDjUhA96deE9d9LSF+qYkMWx5ZTdbbjwL5fxmPGCXNAE0ZxSh8C8axAw?=
 =?iso-8859-1?Q?pc8F/QnfBJ0v8XBw4RmU8oLcjDsRB1h4I0O36Zww0NQSPCrNJJ65xlxQbZ?=
 =?iso-8859-1?Q?QMsW9nGMiYgrkATX8UOIcZq+3syTwKD+JCo/pbIlRFQ+rODEMGzOTaTxwk?=
 =?iso-8859-1?Q?E3/FNgIkiOy7ADnAjJJV9nn1X8UDVY0bpP6LCle4WDoZ60owFLyYVecbZy?=
 =?iso-8859-1?Q?N/1stU3FvTycYZH2hEXjaiU7CZvbhYj4/r662+1axxB9d870JSVaSU9EXS?=
 =?iso-8859-1?Q?XjP7K98qaIHyQ3mVQnxSNjMYGqU5/mImqpjfXEksOgp15qP6KTIRQN5S5f?=
 =?iso-8859-1?Q?aHrtq+iyfpO2/w0dar3IuyKW1Z2EQ6pI4IuoZe4rIjY7uKRPE0XCoFAx++?=
 =?iso-8859-1?Q?y5QyZXuD1gqotXYC8Ca+jb524EDJR7wwfZZFDHivfsnomAb7YJF1SwDPHN?=
 =?iso-8859-1?Q?LY3xm7fGAvvF5vP1+zOUuDb9slXhaVch0LcALxYBxZ+1tVFcnjL5IdoqL9?=
 =?iso-8859-1?Q?de5FgKRplYgEAe/JnPf9up5SGprz52I9ESqugUf9Rcs1dDYBbvmHez87yk?=
 =?iso-8859-1?Q?K8u5FZgfU6m27SM4GOpvWbWFxPqMcoZyHoNLv8EXEJtBQOuB2F8Q61L18V?=
 =?iso-8859-1?Q?Rysj2r9oVTJk2RufQyNn0g2yN5h6x8a/b5m3YGYB37ibZjQtjgsgx/6ZBW?=
 =?iso-8859-1?Q?e/3lmEpvFB31SomB7HQFogbc0uho/A+MAtYNi7SUHJmj4ObNI4BVuWVQTo?=
 =?iso-8859-1?Q?RJC/D6Gxbnd4shGmMzwcFWzA7T69rX8sRHi8AmSkgDjKs6KrWEc8CfaoKR?=
 =?iso-8859-1?Q?lSbN3PSrvTmdMj7tiUwTHTAnlA4kfIjhJEkjC68RjV7aFxXe4eolF/GxTG?=
 =?iso-8859-1?Q?e55EDFwhDZwWpfIQB8K4K3SYHCIYRRVgcHVqza9djfhFyjWNMuQ+r+28BE?=
 =?iso-8859-1?Q?FrLzi03r2aLPw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131cc87c-7d3a-492d-8810-08dc70bbc231
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:38:09.8435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4cnh1AHeloCOtLhXVemrYA4KQhLMMYFUInTfVRwyEqrJKKPDoh9z+yb3EkUC7Te+1rSy73rcX1eu/0yD1zo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 10/22] drm/amdgpu: remove structurally dead code
>
> This code cannot be reached: return "UNKNOWN";.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9a946f0e015c..109f471ff315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -554,8 +554,6 @@ static inline const char
> *amdgpu_gfx_compute_mode_desc(int mode)
>       default:
>               return "UNKNOWN";
>       }
> -
> -     return "UNKNOWN";
>  }
>
>  #endif
> --
> 2.25.1

