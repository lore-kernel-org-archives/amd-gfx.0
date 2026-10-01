Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E29ECA5FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 12:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2552410F669;
	Thu,  1 Oct 2026 12:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ppfgvz8t";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3B410F669
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 12:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxshUxKuiHYw6naESPN31fen3zSNJRkZhPbFhMFrZMzI9MU9kR3JnK5ujbW/IjRZ0cQB40vEzRWmAI4Cri2yzEpT/gJTq7j/n4Rqii/OVCG2xS8VGOezSNIvS2tD9yHM4iX/E6ChB+EWZUF2UhySAyG8qg7/VsOeVPvRClmVl/4zKa5CzDXBf78EY7wADABTos3b0Lq3u4tp/Y5JbOAn3myka+N+15r5JmO4J70CszXuY3RtA5bd4SwJ08J424eUphusWk6K7W3r28YU/VJW82U+pbbfMFKFX5J9hyhEhKZKZ3p0A1EutIN+DeLd2e40T488cpBjoa//LsY5om/9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG5f8YtZi2MJB4SukDidg4T6JJcdUaBKp2fHTNJPj9w=;
 b=NTVoNGL3OLD3L6MNASf1eKoaeqqpRNx5Xb47Q1yk0vm8nf/mzn1riUR4JEq+bovTQ3U9R0tJtOk30dEQtWUFVwXB0MfA5wXkqgNX2aWIqtakJw6U9ki7HJXdzi78oh3RHA8KcD0YSu+PufwHrScF+4kyCdSHnrRpsUTwdWZit7FY/DyVszBG5Kg2gI4W00eRXGK2co1NaLIohOpKwQ2oM3JRh2KIfa3nozZ7gW4a4mwo7+heclifBkZViTo3PI8luwXQEKs2F5JHf4CBVDmTkcU1egYwixDSVsFPNAjSxD5N/4P1kzfcWrDCkrAWJQyvFojf4c1GeZu/8p9RA7C9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG5f8YtZi2MJB4SukDidg4T6JJcdUaBKp2fHTNJPj9w=;
 b=Ppfgvz8tefTsw7VLEOjSPz3NImQh4ovY/fIfN0bnSMcHrK7Y8VH4xckj2nKFqBA7VJWd2nbzv2/MLz7O46BswD7qEoCKHMx4GiG8/YHx5CtuvF0Ij9wHYqB7MziA5UZG7+SWwpDOQ8VH+xB9Ia2xjO3ULZTSxH8ETMcm1gE4IIY=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:45:36 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41%4]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 12:45:36 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Topic: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Index: AQHdUPNWg+4EkRVVm0ePmOMosMLPZ7boNa8AgAAEOYCAAGi3/A==
Date: Thu, 1 Oct 2026 12:45:36 +0000
Message-ID: <DS0PR12MB79937571F6D40618F50C6C49F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
 <20261001062717.93329-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20261001062717.93329-1-mikhail.v.gavrilov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T12:45:35.833Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|BL1PR12MB5731:EE_
x-ms-office365-filtering-correlation-id: 27e81b3e-ed87-4e1e-4a1d-08df1fb9e3e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007|4143699003|38070700021;
x-microsoft-antispam-message-info: 9sI00qVjOtBDktn+AZWKicwwG8HYc83BRB2aNCV6r2M7nE9Qq34q+OXZ5YMvP0epzbE7QGKIIbHDO1lfSZtlDiKBnQK2WqSeXwGc1p0xOqWiOuo0pFkOWp2irs4ulBxpCDEHtlxd8El9NHngdPvogHP9WQDBVtbMwARrmsb1NPBDWSEiVaZ0EwZYC/fVMt0WUfMQgQDBfbTG3DjoxpfV/BM45p67RsS8sQ7m24u1VGzgdsurDa6fdLTktDbGEw3lfrJjru27niscVboYuS45AzelZSZAI5PyC/syo7vfah8bgwt6cwGZ0iVqpMcRiefg+farsoTNWHZQI8ffIrmCSJ9mbBii7Fgk88G4cg3qaCpFXrRV3bYEj387tjPeaii0V1pTUVY4wSS1jLU3wKgsCBNBABvXagwcSubfZVZmX4B7j2xmQnoCdJVKf3qo4QAaNL+ju7HDCEm2ZUt+EUL42LnF02H+G7dkhToGJun+x8hCOXNUFlgxUmCeyQ0H4wuqm6Q8moPmXmZTEKHInIr+5n6U60V7n5N6LB6MoytwE2c+4MiImkHw9LlmdkYUY4NaQmYEhMD1O1ndTnhelKS2fo4gTpltg/7mVu0FcNpVbNXY5KiyoR8H6a8fvU79UOORUadAzrGh8BQkVxEIHzQPKydLpG/jNktJGFWGVkVkFOwz+dDm+Fd5ts/3Z2mAQCu/umiZiDCXIiKLXuaCPMqynYD/MRagyXmsQO5IMNZtDdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RvF7xQU+LeCnCA727h4pg3OBuBL6VoBF7He/HyoanORPDN1sy6GwIYvbK1?=
 =?iso-8859-1?Q?e+FT9pz819m1/1VOf99TF8WI4eOdFMC5krEdYGjmqHutDWK+e4xt+L/aC7?=
 =?iso-8859-1?Q?J6Le2L9i+kPEJdF5bRs1LZmtQElgye08J2T9nZ9pNu7WYtbTfUtwFhWU2b?=
 =?iso-8859-1?Q?XTmAnpWbwKJTkY2TBr1v+3mTpqmm2CvltEovjregMzHZbtTx5lEvLy0CgO?=
 =?iso-8859-1?Q?HTFrRMxtk+vdnBiQyxvvVvXDHUOZA+ExC5CwUyZLrHidvvFm+Gzy2/4fKd?=
 =?iso-8859-1?Q?Op/B2vrBBwxBDEuRlKd3uNZ23Zut5TBjPtyRlJsIOXKfSZN9AAHq2eu2cJ?=
 =?iso-8859-1?Q?/iOdpM6T9ddRRDJC13uu3biMwVVYEqUSTdtml0oTxqkX0cpX8KLL9dgDH7?=
 =?iso-8859-1?Q?I0yvn7F2TVm0OTQvr/uJz8qE8Rw43McchQ3dn+dLu/E3q7HfyVI4PSunVH?=
 =?iso-8859-1?Q?OrzzcuuGP0bkVbguKogjZyyqkW5tbnIdalfU9Cemuus+pdG89F8bTx1/VS?=
 =?iso-8859-1?Q?hV/v2wRQ7srEgWW7ZD48dKJLx9nWgkgTAOhy3N42rOX22LcEKqaMLHLejk?=
 =?iso-8859-1?Q?iII1txjNDnDcmDSJ22kwJhhPBMAxwnpXfKSA4VSOpQvt4AdtsW2UF63obu?=
 =?iso-8859-1?Q?J7c/WSsRP6MhTcAdLHKjIRkdKF/U0F5JN8TtzIs9nHGLEUUp5MOSTrpLIz?=
 =?iso-8859-1?Q?MU6eYkFkxAOvBEYiNxMGa8v/MipTUGrOJDQfnnmEgT288UcaLDscQA523c?=
 =?iso-8859-1?Q?o8MrEa8v5xIQy9VLo6HSMp62IEY752dA5REvAtbL4PxfsvJzgP529FS2iY?=
 =?iso-8859-1?Q?+03RhOPpnI3PnKSsBDSD/H2gtE1pW2/bLMw/gspdCEvvPuUl+i+VBl6M63?=
 =?iso-8859-1?Q?h6He8ktXn3vVep0B+0Is2Dfn6C2lMiWsO6cX2G3MY/DL7JcZt74GJvU618?=
 =?iso-8859-1?Q?WmR00hDJbmiYPbK+sPyQwtuo361L2wM++yTatuE5dfE4mr3vSIP83th/Rc?=
 =?iso-8859-1?Q?REEXVtcTRIq0zJNIQRFJTZ3Xw9cbDxvg8s5hTVy8/2Pc23IC2MJ4uInIIv?=
 =?iso-8859-1?Q?s2lDNRpvrEKiZ68CAh9Ax4y+ZTVHVVmpM/4YE5ty8J5FS1K0EHxDEoUtOO?=
 =?iso-8859-1?Q?bxaeYXfXpdB2FRlyoVea1wOhiugDq8sbHhJYE0ENUXN00l6VogGXUs+lT5?=
 =?iso-8859-1?Q?zPzq7b4XgTF4uZwh+LioJYfac1a3dfRlt3E+5ZKrxRzn27dj13oT4j7KC6?=
 =?iso-8859-1?Q?kO9+2l4SuhiCHiIhV1tWwirAzKf9ne4UoBbrXXzb4eqoJtqOx7hLouWG7V?=
 =?iso-8859-1?Q?VQn0dvb5QCmY0j3xlk+mliNoyQ9+26VKvhG841BUujKuUp5xRDzqasJ3kQ?=
 =?iso-8859-1?Q?7iWehSmDUf2DR8vEh7WmIZ+GLmE9p0qiFOwwwtLbJDjX0ENbEW3/ZXYxiJ?=
 =?iso-8859-1?Q?/tcg2v8zBAWNeDS+R9azwEe9St1wxWaSw33rcqHtpy/u78dFQ8B0MNE4uT?=
 =?iso-8859-1?Q?ytSbXMNxW3eSPz+prjJ3Pvv8IsOj1I85plNZ4SCJmau152uap9EJqZNsUW?=
 =?iso-8859-1?Q?0SMAJllm2wkG3DeFXAEwxGCLnW1vl8giPg2NPUxQt3cQu5ShOC2n4LwvOE?=
 =?iso-8859-1?Q?0anwS022oMn3HgpjfWYeQ7sLiWYhD2qHGpPMCAsmWeUyDAPmF+9XPmHHmp?=
 =?iso-8859-1?Q?Vd7qWUuuLPNi0BTKeSbXBYssFSuUSqhjX7XcYJg4lV1qRtjAay7N7nqARr?=
 =?iso-8859-1?Q?S8x96Bhk6CVTlgXbMLu82opVQNChmnpqu5l6bhVFZxfrIx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e81b3e-ed87-4e1e-4a1d-08df1fb9e3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 12:45:36.2197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sEN6DTOmp/6jLj9LX42JNdvyBu/KHCe++6SertqJvVLpgBn0ADJnbJ5uyqOpnhHESDqxwtv5zp9Yvkkd7sWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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

Hi Guys,=0A=
=0A=
I just tried the patch out as positive flow tests (basically make sure umr =
commands still work before/after) on my gfx12 devel machine and I didn't no=
tice any problems.  I've read through the patch and it looks good to me but=
 I'm not super versed in the depths of lockdep.  You may add my =0A=
=0A=
Acked-by: Tom St Denis <tom.stdenis@amd.com>=0A=
=0A=
Tom=0A=
=0A=
=0A=
________________________________________=0A=
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
Sent: Thursday, October 1, 2026 02:27=0A=
To: Koenig, Christian=0A=
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander; Prosyak, Vitaly; StD=
enis, Tom; Mikhail Gavrilov=0A=
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the GRB=
M/SRBM locks=0A=
=0A=
On 10/1/26 08:12, Christian K=F6nig wrote:=0A=
>> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock order=
ing validation")=0A=
>=0A=
> Well that's not really correct since that patch only makes the problem vi=
sible and not introduce it :)=0A=
=0A=
Right. The user copies under the locks come from=0A=
=0A=
  566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (v3)")=
=0A=
=0A=
for amdgpu_regs and=0A=
=0A=
  37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO registers (=
v5)")=0A=
=0A=
for amdgpu_regs2. I'll use those as the Fixes tags in v2, together with=0A=
your Acked-by, once Tom and Vitaly have had a look.=0A=
=0A=
Thanks,=0A=
Mikhail=0A=
