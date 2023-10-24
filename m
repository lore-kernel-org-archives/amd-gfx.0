Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14B4C07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 15:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C0710E3D6;
	Tue, 24 Oct 2023 15:43:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5B910E3D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 15:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0U/wF56DRRIUAVwduzmoQQo2FGONotayQ0neFA1mkl48SSYZCgtcDKEwda+u2U2KNaUSTfqNoXdOO2JmjlRs+L1eAGCwqQrkBRkI3rNU9ColwLzEDuCAOpW15cUeLxaRZD8DrsVl360tnJ9wsXpfjlbkIFO2jUT7oJybhQEXc94CdmqneORL1M0Jurd1OPQNmbMUtMQ7WhfaTa6eYahuQXWNA7eacamyH2QKwdxd1tbxEccOmwqMqUn5maTLA5HVVVK3PAJPVExKH2mUvJKmSq44SZvXZYQmycNF4K64mtWVQGsutM97f7gT7UbKRlZqsUOeyA6l1iLY3cKVs1w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzcOmPACt4GufG3XPcxABRpCDwIfNK39Y4Fhf6klgSw=;
 b=MkVzzP8OsksbVXA/HfRk7N2mQpHIaUoCUkDJf1Jts8y6NOZH2rirPvqTD044TZ19ZjoqBbqgSc8DI4BDupnrYsZ+MZTJua6ciOLSFyOF1GVhKwRSayQnW3BEa0BLhlTuWpU26SQFuX8Qr/f1s5jH1ZdHIdfXnIq8lq56dcCmhg9p29GkAViWxSU80NX0C5VICCUXM9yvVtZe1kc9AfbvphRnHKWIXBOLfVVICSPSh61fjectmtiJnzNJQz+3GMRm2XqGh0bbwBUIcCafWWgx7iBj8lBwiMBxR1sz07a2LtJ7F/Jncg1TWLnzsVsojPnbvZdGH4DNbBjdLJQdMDr3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzcOmPACt4GufG3XPcxABRpCDwIfNK39Y4Fhf6klgSw=;
 b=Fr9vIB6ct+Tz8svtCDnAQBMnv+C7wVBysudziFYvKEimCTzQeU2FL2LgAU1kPa7MZWZMSW9PvOdUtWBs2a7kTfx1g9rpjfK54r+Zct5oq0lvCCfUWwcp8O41BrMuyOAHJLAuC+jW/pXLzBvE8Xf3Pk5PYbgtexdzUk7XfQm5zxs=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 15:43:23 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 15:43:23 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Index: AQHaBmqP0fq+K7h90ECmzL2vU1wcirBY//MAgAAQCdA=
Date: Tue, 24 Oct 2023 15:43:23 +0000
Message-ID: <SJ1PR12MB6075A33D9EB83D22544A4D7EFADFA@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231024110904.281991-1-li.ma@amd.com>
 <CY5PR12MB6369D44F26175EBF65A286EDC1DFA@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369D44F26175EBF65A286EDC1DFA@CY5PR12MB6369.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|IA1PR12MB7494:EE_
x-ms-office365-filtering-correlation-id: 0a8bcb80-dbbc-468b-fdc5-08dbd4a7f4cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Td3R9YXcyCN4zyqnC8FWqNQS0+lCDjPNy3WuEFAzBBdDDKiVuE5o7qYtVnQaYwd7sk/KVlYry70Vt2mK1xVAsiolMnbMhGOFywcHBG0d52b8SJqo1ORKxfGQ1KTghMQekJ0oaLh+6nNyGXnpZFveIxIkXO4fSXbIioGBZdjrlnSI1yeOafvMeiU5ylxAa0+OCoif1mxN4mFUj/IHDky0gwHIHqIfjFfOUeNxvZ8pfQOStObZvbnwJoGlounZNA03XTf21nR+C7SgjJtYuHcrRCkJz+YyZRuVV4TyWpGrCRd4J+xzf0JwqdHvwTEHryHIlicEN7kNMgILM68Kep3IcxeVdRmStNmt4CGresVVNdRbvCKyvKVMcza1kcdAjphgxyeNl/wCMl14pCAtG3vCRz95urLOUP1RvYpY5Z7DOHyK/g08ZrToO26ndoPe03AYufLmxojxXGSc1dF+mfHFlzqn/UJVXRXs6H0yPeT2jNBmBiMCvfkUzLuIWk1M4ejfroa0QTu8TOPFiS/8OcPvodh1mj/aRibkjiRtA+Zr/KB6ayPCqqsZmxMxi+9tfzdHDxK8rEnN9WUNPUyQx+gi9USoUwTFawU/n3H+pEqUTzPTvFCHtbqTSvlp5Hl0pqr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66446008)(83380400001)(53546011)(26005)(33656002)(71200400001)(9686003)(6506007)(7696005)(38070700009)(38100700002)(86362001)(122000001)(4326008)(8936002)(41300700001)(52536014)(8676002)(478600001)(5660300002)(2906002)(66946007)(64756008)(66556008)(54906003)(76116006)(66476007)(110136005)(55016003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?onXPxm/7PASFY+HDFmyf47kxnJjHjE4SxCJKd9UcrUC9r1QrRhemWFSB8mXb?=
 =?us-ascii?Q?zJ5eFyiXLmAdnDAz4b9VkY1QwbaNGcidJ3+R5SEizF7GkBoMuMoDrXtezwbs?=
 =?us-ascii?Q?8M0WOOmSEe3uG7KDtoNO4HYAXTG8Sjpo4p68nArFF+bOtxzGysX7xkg8XjHx?=
 =?us-ascii?Q?/wainM/i1PBggRJMwVhrMY7aksm+tadtB49SWjGs4kbmFCJKdOwQJZQNqYAT?=
 =?us-ascii?Q?eTkwdmEMqLJ5lyIN+nMFIIPynwrJRjAKtYodcLqO8o+9/q6waHZybJgYE75B?=
 =?us-ascii?Q?M9whYxfEe1U3aGi/OEx3RIRbZ+Y2Vutq2v6U3OD/AKqx5+M3OZ6VFBAFf6fl?=
 =?us-ascii?Q?iv2Ky9+3tv8q/SRCsJeeZ9wQ33PGTLZaDMyJdgIzpgx3kvlHsI3CizHFbWWF?=
 =?us-ascii?Q?FIRi9iCR4tLNwg+jlMn0KTj+o/nnrNdHmVAuKw/N00aVDAk22EdSADfSPh+K?=
 =?us-ascii?Q?/HDWkeuEkXnIgjUxdB0SoOVM1C7PJJ0Z8YD6IcZS3+deB6ItpeqmSdfQHWB7?=
 =?us-ascii?Q?MjnLthUTlSKeR2u41UwBPUDiSOXieeAgNXjB6WcSKx3xJMw5MJ7PRKjeNWwm?=
 =?us-ascii?Q?aV2/mdD2chGOKzYj0z/A5WImrrMgtz42yTa+kapjsSZmKuTUBPieuKb8EOIT?=
 =?us-ascii?Q?wigbMejy/nlNPnmnPQlbr9/10TbU+llTJdmKb2gYPq8jTmeuhXoJyUf+MQaB?=
 =?us-ascii?Q?GDz8PhXeAblf0AphZYFOYwrLhfeI/WbWVFv600sbnN15Oja/Vc3nXnFZw+AB?=
 =?us-ascii?Q?FuEmRhaeqGJJaGq5XVSTtEp8mAfWqyAgZepm4uxE6upMI2dxKLQ/2SYiSMou?=
 =?us-ascii?Q?TLYG6HFYMoK+94bGMOlwJ8Th5i99RWPIVGyhdofvgmHAyxeqtI/uoCuEsZEc?=
 =?us-ascii?Q?W42LX5r96Lv0g85dlj2106kH3egG72QKUcBI7Ccz1qA7y6nvAv9tSVNkFFa5?=
 =?us-ascii?Q?R9/PI0i+zapkYWasvoWyENwrtByKamWukSXPSxFAy/WyQO2Dq+W0dgIG5V77?=
 =?us-ascii?Q?yrsN7cFnZArwxEiNULzVPFj3G1ryjARM4rHr2aybrsduaZY6+YIUfdryZIW1?=
 =?us-ascii?Q?8oeHhXL/wgI0/4MSyiHHS3dfUzvr3fFnWRXY+bgELI6VvPLH/T9vnurUdL5I?=
 =?us-ascii?Q?webHJHSDWz2jsL2HdSeLrtN+NQAlzmdK6jHyhI9UJKhRjP0NOkIOOGFzwstB?=
 =?us-ascii?Q?anCHWJLiizZ9G6166uLy2j8JjJn0V42JVC6v94HO8o2SLirXyQLdgC5VWqzQ?=
 =?us-ascii?Q?QpJ7u/fEUDxTSPk7gOc1cpCQOlBBUyEuvIfzjq5hU7v7jeGSBaqMyJw/AI0/?=
 =?us-ascii?Q?ZRd7h6UdMnBV2YW/xHXQr+sY3bxpPBe7SYe6+G+6a2snklUXG+T552F5VMgM?=
 =?us-ascii?Q?HlHsuw9WOve79dj57DcopfVUvLMC1m1xx6Dj4eeKY+5SUIzbfVuHab+X3UiW?=
 =?us-ascii?Q?td9bOTuX93wTGU5gfFjTXBwiqIhes7dCN3L2EdiHZhLIpkapNhnNkJ53pVat?=
 =?us-ascii?Q?oekLiDSNhlF1q0EYYEWEC43JQy+R2vAiFov9t7dHHELjYqqGTXD4UtsOljyS?=
 =?us-ascii?Q?N7MXwHWse7HOwuF8X5E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8bcb80-dbbc-468b-fdc5-08dbd4a7f4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 15:43:23.4463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOYM6kqXhZ4C/QEqMrO9wiMD27x4aDmcBRTCvnj/Wt8uuGbNnwqO9DVBIli5o+Sl1hUwDuJqAASO5c4SX+537A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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


