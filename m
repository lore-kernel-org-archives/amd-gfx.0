Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F0AC07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 01:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F1510E52A;
	Wed, 25 Oct 2023 01:26:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF01710E529
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 01:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTF3MhvMWDh8PuNc0wRHUcJdY6sZFsTrxO1UrjuEHkpYOTcwjVXgwwPMvcVYXjW8In79rMI6TXV7lJ3+/csM2StsUnVCOMqHjRdXPDhLxUPiLI/C8IL5vMfiO0MjtFBXj7kivksqRli8ZHE480bGMXZAGxxx4GkiCmKj4qGreIKtYItEdVz4Dt1ZlG4l98i+bCzRk9ssvH3D0EtquqPrlIGGDyS41Oo5mmoSAQ2WVgKkZq86RXKHT17bzKSHsj2L9GBpq58jfA1EFxtNxxr6j510ASXQ6CaRbaFBjoNpEpytAnoZdRbEDsYSFH2zUmih4zHxu7k0Iur8EWGHJquL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzu1q1ZDplyKWm4INoTnyKi+WZ68tWH3Z1byrPNuSbE=;
 b=Pnh3CTl9kyTHtKWiwLlK59IwQuFEnW0HF9nBsM+EhLaYq+0GslSLQYBX1qRQEWmc3tioMoiV8KP5J/v/nMunEeFCYeENbxfJEbI/MmlUuIp2G3ZICBxbz3BLOWAbc9HE1BnifHLTksAD6ZQMTdRhXIi73hgY9jOI5MHMxja6kO6GBw7R3H0DIeQb7SgCAxsbeRyaU3pKs3mAESZKJ97Nj4qFajfr8W6e6NVGsXXiZHKf33Hh6+dA+alc8FOIbcmY1UQ5RHzEyyA0X6m/5PwOeR7TQVNKf5ShKPPTCafxSk2n6+lEBBwDeO9PzqqG4n6euceZI4y/pzhKhbTaA2H3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzu1q1ZDplyKWm4INoTnyKi+WZ68tWH3Z1byrPNuSbE=;
 b=iL5BzqwVBTNwUky+D+/qfxfvM6bDQbSdPeKrWiRMo207Yo3uImz/qU0QeveZA7DgYyj4o7RMJr/fwG8YaGvfEf7C1qAGYcs3Y82/EXWKDFlgcAvyexvXBliWmKvwuko820vQ9fjbPHPjuu7HHV1/97jHlGdVwCMMQe6dH9HWqww=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 01:26:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 01:26:19 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Index: AQHaBmqPzwDCL/V3QE6c9T3UcZK3YbBY+RBwgAAbvoCAAKI90A==
Date: Wed, 25 Oct 2023 01:26:19 +0000
Message-ID: <CY5PR12MB63692FB1815CA4D45F70B697C1DEA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231024110904.281991-1-li.ma@amd.com>
 <CY5PR12MB6369D44F26175EBF65A286EDC1DFA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <SJ1PR12MB6075A33D9EB83D22544A4D7EFADFA@SJ1PR12MB6075.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6075A33D9EB83D22544A4D7EFADFA@SJ1PR12MB6075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ca35747-e9ad-4540-9740-7f0b121d4e66;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T14:04:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA1PR12MB6387:EE_
x-ms-office365-filtering-correlation-id: 60a5591b-343d-4f91-9d0d-08dbd4f96436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WI1SZKUY6esvX98D8ppJomjD808xD8x0aUvld9wXNgUOd5spjrMcS/6bPWD0CI2CqZ8j0bDroOXSa+2hqPNWCRnkgnxBWpNow8Kod5aMEy/BPdCStN0OxaSX8EbrqVIIVfniAQJLgt3I7oEot6PqJjeMczhHSdc0wJgCYTLcTV/ZmL2fyaUXWOlNJabMyq+JjCuFnf1Klwrl/E67VC+STkLdsE4348SVECAiZJWfGHVaaIwvQSatsYAGQL8yz0v98QfogkFoDu6yNa3ZsoMppw0+4WwbssA45qmYrlbYPXDs7MFeQOpEcl6UZkExVJ+5Vg4Oy12P6MoN+CDjZstDHBgUIHpZ9JXz1FU4hUIf6tuav5ittpAdtxlp2Jo193Rkiu6nCW8StS0HNjhuq39+4JMRLHYEmJoyyTtbIUkF0jhtQ+HGsIysW8viH2akzvL3kD6slRL5PAQdnp5QZvZK0IuEs2eyc6rCb5JUbm/yA7qBik2uhRv/mAsH7ecsgajTdwZuBa0azrrid0K455f6dGDQpjX4+/382y6gO3D1hwtMTv08UiB6pTYihmQ68ZviAdaTQIVqVmtVYb0Lz2QCaDIvVTN5dp+eByHKanEvpDgIyAOwI827dI0FwuhzlAs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(55016003)(33656002)(66556008)(110136005)(66946007)(38070700009)(66446008)(316002)(76116006)(54906003)(38100700002)(86362001)(122000001)(66476007)(64756008)(83380400001)(71200400001)(9686003)(7696005)(6506007)(8936002)(2906002)(478600001)(53546011)(52536014)(4326008)(8676002)(5660300002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xYKBDM6BTnQX0KyQbNCHLzY6TZnO6AafE/iOWJyVCTXiCQp+uBFVrNY2gWJI?=
 =?us-ascii?Q?71eZJN0s8rIw/zDuYm5q3OBTUslEq7ECWWFV42IcmXMMU57l7WV/3aEk65zb?=
 =?us-ascii?Q?dlXLrNR2fPMNmMxiMwzkkiX7bvM5N6Ic99up6bY1FgDRCA1r0OLqeLQjn3Dh?=
 =?us-ascii?Q?7wZ36ENDlKimeKEZGdaU6CARETzop5riigxAGic0RzzDDtmOIUEMbNijg9kF?=
 =?us-ascii?Q?cruFXAGd150wwPjWtfsPwvzPWKqOG1CEOvzvkAFcM39oMCcNjTfZp+K3QooE?=
 =?us-ascii?Q?Q8A1kgwJY1fMiEaXNZh+s07ImPGZ4ELclr3z/mscxyzL/nlD94v/cNBc0hEK?=
 =?us-ascii?Q?KSBnUmc+xAgkDTrtmH29beJv4n1KdM1tDZMiG5kQU/4x5Pnm07k4FoI0e5TQ?=
 =?us-ascii?Q?mH98hza0EY/FtGGacqI/LOMUKmzt6unpxiBktfqmIh4b9/ITHhv14+Mj0aN0?=
 =?us-ascii?Q?+dgKRmSQYWxcBE4gxRGUJEMcZ7473OxgcXrf/7h1mA7mpTh9FhGrrg53Svau?=
 =?us-ascii?Q?9QeYHRwKPulv2PGT0pVyEwRQNZKYKTFAxvpRcmK1GPw0O0UBgwv1hRgkAN6G?=
 =?us-ascii?Q?wTuQzx8sZo2L/XGWCbAfCKRNp3/xI1HgbjPlMH6fNEv0SGy72pCGHhtnzUNV?=
 =?us-ascii?Q?23tMJgrzIyaDo13ZLmeDNO8D4+6HlzHZ13imqNyQwDB4ocAcDvTeIzsAv7OH?=
 =?us-ascii?Q?Y9oT58UzDyN2o87wP4NkRal4PdhNtEldL3ts64M7p5HinsS6dSiv4goVXX/R?=
 =?us-ascii?Q?R8s8CJ2imbtqyErfqIHXw2Eg3hWNPsJqSqzK3C54PyruKCPLiR5y0aZW3i7r?=
 =?us-ascii?Q?ArygjRxCxtEtfmO4JOBj/3hxAdAXF8czsVc0yB3zx2vBAWa+OZoqR1r0JLDo?=
 =?us-ascii?Q?GK1oKEqhopOk42qULHxiXjCtUhckdq/0KoYCVleAWJ/ispbSgO3+IlCowssa?=
 =?us-ascii?Q?0/Bz+X9TFW1232fJ6Jqiyqyav8H5qzaB4Eo3vQlF+vhj/ys2dllY9iScahCa?=
 =?us-ascii?Q?ggpsmTd/u12kyfV84bFoLTq0sQN7uiXofercwxCroVQPKY23kuYLBKe+TKZW?=
 =?us-ascii?Q?JFwFtfHMWvu2xpOk81h2LQlBY72nqjxsOcIt5sarmSRhWFTpFQyS1TayCCHd?=
 =?us-ascii?Q?cPTGVtp1i+tlKN2Re1vAWC0+2TW3wnU03EBgmQ/SS8YBps2IzJ4F1cM/nIaT?=
 =?us-ascii?Q?UgA0+Mf7q8uxi+qz9jGVOJuFv/IHDsMd0oQlLCRh8eJZ6y2snQaPh9eDl7Be?=
 =?us-ascii?Q?JvINTk/AFZRq2k+oGoIwnIRMcRTlLXPyKu94jPCpiI/ihe/I1y28jwN6zras?=
 =?us-ascii?Q?ZCDZB9pSjLzxZv0KY+exUOeO6ELqgN3GfxA6PGRbYU2FJQB1qF4i4UeTAYgp?=
 =?us-ascii?Q?xFwsa6pPRqk4/LHRu7xuOj6buy4zKNe8SgjL6hmL5k5Pjw2sUs1qtf4q5F1I?=
 =?us-ascii?Q?fr5+5gl95ejOuJiyHHvd+xP7omX26csYYkjdR53c3v2ymi1/ZtDjWBbYduM8?=
 =?us-ascii?Q?KehnTenf8ZR/P5SpX8qBfUFZf1x7Ob9+GfbGVEDu/vcKycmzyzlwds3ZG7DL?=
 =?us-ascii?Q?nj0IwWgsYghrtRiGnxU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a5591b-343d-4f91-9d0d-08dbd4f96436
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 01:26:19.6014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67eCkQFRgx6ldpUYxu+FNaRHkQYnAdfUsHtAQS9oWqdfHIZy/HYGJEMT/a9AYkWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I see your point. How about this one ?

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,7 +4290,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%02u W (average GPU)\n", query >> 8, qu=
ery & 0xff);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size))
                seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, quer=
y & 0xff);

Best Regards,
Yifan

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, October 24, 2023 11:43 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm in=
fo

[AMD Official Use Only - General]

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, October 24, 2023 10:29 PM
To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm in=
fo

[AMD Official Use Only - General]

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, October 24, 2023 7:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info

Print the digit of the fractional part individually to avoid carrying durin=
g display.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 358bb5e485f2..cc853559cf0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,10 +4290,10 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fil=
e *m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%u%u W (average GPU)\n", query >> 8, (q=
uery &
+0xff) / 10, (query & 0xff) % 10);

Would you pls elaborate on this with an example ? it looks to me it makes n=
o difference here.
Li: If the range of  (query&0xff) is [0x01,0x09], the origin output is x.1~=
x.9. However, it should be x.01~x.09 which is same as smu fw.

        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%u%u W (current GPU)\n", query >> 8, (q=
uery &
+0xff) / 10, (query & 0xff) % 10);

Would you pls elaborate on this with an example? it looks to me it makes no=
 difference here.
Li: If the range of  (query&0xff) is [0x01,0x09], the origin output is x.1~=
x.9. However, it should be x.01~x.09 which is same as smu fw.
        size =3D sizeof(value);
        seq_printf(m, "\n");

--
2.25.1



