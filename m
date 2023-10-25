Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD82C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 02:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDBB10E539;
	Wed, 25 Oct 2023 02:08:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9421210E539
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 02:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAo3fA5kZVODgMRyoSgBl+KuAMVsTeWpCwB+dvgkY0hHPdmk/4F5upozFqTbB2JSkvqpjUIXJRepSW2wByixUUu5ijXoxaFBygbaE07GhxBxLb7CQBmgJuBM2YuXUqQbLcibMlOmoPfExGjxJ94tnKnEltV9GcjKyufC1gqOOnHAkXkmS/z66faQNxb4MaGBS16V0USwIWyBGQgB5Q+xLgAlEXtIZz1t2AwIAecYAKaFJDzCIEhn9d/6xuruqcVQnZLNLvRdsj/wHLvJSvViYUmhXvsLX7HuEY8SOViEUTjO4STBXNCz8OQcVw4zErZIzSAlH5NjXovrREvugM8knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmVY5LbQxFE1W9T+2mwp9lePmw/ue/HModJpDTGkZAc=;
 b=MJXa4jmL5hx/b8a5e/zkc/gbtrQSR5dS/3289rHP9rK+uyB2FREQYIZI6t0cDStEvikNhHw655iB8BPD4gIA09tfZnfCznpYbxYeoXqGxGsOt5JH06xpnpPCQSYGu+EX9uXNp3wn7qjNorr9cPzeOA/UBFw5XYeJYhKchMelShTwK7SKV9IONofcxr4bvPbUbeors1BhdASvBWrFwS0FA01JOD80cM3DUGRl7EEZF72tKLhwZMH3SvDAGYsMPPZic8d4hhvTV0tE7rF4n2zR9nn3dzRkE5e43CpPAXGGpw4Fu3VprVCAOGaf99VW8ZVSFKTkRUXh+ow4fkg2tgMFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmVY5LbQxFE1W9T+2mwp9lePmw/ue/HModJpDTGkZAc=;
 b=HW5f8WZKB74CWEcSqpsDknQmQWGTScUxqL6XX+B2r9xjGkH9gm41WCgdeWbkvZW9lMTPXgw5Fm5xM1nzb1EkBSGibMLEi11REsQiUZn+wTpQep2MVf0Y27hgIH1kj1RVYRmVGAdvHg5/lOFq2284Y1pEBDyllQjbbVnT7gdrrA8=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:08:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 02:08:52 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Index: AQHaBmqP0fq+K7h90ECmzL2vU1wcirBY//MAgAAQCdCAAKexgIAACuiw
Date: Wed, 25 Oct 2023 02:08:50 +0000
Message-ID: <SJ1PR12MB60750A848573DF057B1E8CE0FADEA@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231024110904.281991-1-li.ma@amd.com>
 <CY5PR12MB6369D44F26175EBF65A286EDC1DFA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <SJ1PR12MB6075A33D9EB83D22544A4D7EFADFA@SJ1PR12MB6075.namprd12.prod.outlook.com>
 <CY5PR12MB63692FB1815CA4D45F70B697C1DEA@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63692FB1815CA4D45F70B697C1DEA@CY5PR12MB6369.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|SA0PR12MB4365:EE_
x-ms-office365-filtering-correlation-id: 8b5e1580-7298-4908-97dd-08dbd4ff54e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YbkrRvNI5NQ+H8MaAJgfSCDQw2bYwGl03reigAR5xDNF6zlJYp9QZNmHXuMhBwHASrm5iYMyIqEd+zmf+SCKnOswCS4IBCjchrxp6LQ3UnbSXaiU6kO+gBP+BNKV4uufcRx3RK5EU5FnhX6e5ndIS22ZmTpxS8Rc8VHKZI4uMiGlfXDvpcC87kZlBjoyGhjzbLJMKLWfCHNLubqfsprAJm8E/t2FyTOFp2ID7Q9M1z7qu4tsdqJfPf3YTee/tLfvoJxMzeA3pmWBLllrNNs64M7FSO2aGhLG8AWuoEO4FTwb+BXEy3rS8w2YMgXogX34es8yV+qz0kTda2qok6Pue8s+Y/JR3GWCxss4d6fTXPCdJYyG4UFH+OlUTRQWW2Api8vdWqqfcCMUBsHXe1is8cYuYgIxElnCV+75vXMD5PyvZMEm3tXGqkXSewa9GY97UW0DEMK+QXx2yoVlZxL3IN6GRCkO1UCLD9EYVk/UYN5MryzWE6b9XX+nIU81YyIINQUQwFv3mZT7MSalgx4T+1S294VIMPK7Mj7LoffVuwjkhkRqX8zU6+CZnL9vQ0wcd/wfLqin8DrgWXyOPNAdRbHbUtCO8md7YmrnkWWataFGDfxhPlSgEybSP4qybxGj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(76116006)(38100700002)(54906003)(316002)(55016003)(9686003)(66476007)(66946007)(66446008)(64756008)(66556008)(2906002)(478600001)(33656002)(86362001)(53546011)(71200400001)(6506007)(7696005)(122000001)(26005)(5660300002)(83380400001)(4326008)(8676002)(52536014)(38070700009)(8936002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oAuc3a5iDIokjWwDyxXlKRbMCA74fy8zT7UfzgqFGdXQ8w7GL0jPXmTScHqV?=
 =?us-ascii?Q?fgmvEFYNyiZMinYy4DFRlFSVyOcpfU8rSz2SM/vI+qJhCINpT4oAhgH8415j?=
 =?us-ascii?Q?kYhWQigrkOy6zVc4WIkMd3ZUnD7QJeKdZ36/4jhoHAgOHutGWku+ymbN88nU?=
 =?us-ascii?Q?e5Vhp2BcNUjjfVFkoMEILBZjuy158oWOtzxJSalzry6xV4nUXNsOTSIvAxsL?=
 =?us-ascii?Q?xOMijMoYvLuGXFolkhI8WVnYRvtCShZ/uQHhVdtxmBE7GmdDKPccYC9NzoWX?=
 =?us-ascii?Q?RhGIC9q01MW05/rEgjc5zLTio2yyxWteN0AZzkno+sWM9pPII5jcXR9r2PHw?=
 =?us-ascii?Q?duCHGicELuTjgLONs2Koh3EuY56tMSYfCl14NZUkCBO4scNtKXfqQ9YZQkWv?=
 =?us-ascii?Q?grwUqY/wgul1yl1ShzNulr/7U+MzQQMp3dtsuAGZbM+UZjc5Nz1SUDsV37P/?=
 =?us-ascii?Q?WvrWSpnq92KZx18SuqXzGl7RhKKcw+IOMJcHhP8b3JKjVxN1Wrhp9f8dOSZq?=
 =?us-ascii?Q?rTP8kc6EPBLp7484w/WN5Reu06ZhPc3z3plOUfKVNyE1CEWNFnsUrC8tx9lI?=
 =?us-ascii?Q?eE7Ti3SdpbGhCMhNf6b3b4YQ3IvzVx/QnTCltKtwo55jG8lojriIBPTLbI5s?=
 =?us-ascii?Q?U8tzz+hPJ5nom4j6sz7iSibDcG3l0seTUzgYQWwjeF4VIjmqpYKYZnhJSSbd?=
 =?us-ascii?Q?Sj5hyNl3mX2ottGL7lAAnGsCouIRsdvhMpSs4sSmLI1XJOErWz5kF2AXZw8h?=
 =?us-ascii?Q?g40zsmp0xqjGCvZYWK07MPJsoNwExBRwGdaBsks+Nh1PkNmYu+TUKwp3XvOV?=
 =?us-ascii?Q?a7f8NOpe4JTKNZX+8Na71PWGSvwZ4Gqaie2YTfF+wDzQuT4rmxy/Ugo33Hlg?=
 =?us-ascii?Q?TPq1FlagYCbC2VJ27U+sRlSJqUIx+2iU+Y0uI7cwIZaAXrDUugIP/4u9ohHl?=
 =?us-ascii?Q?03kuMfF78l5vJPTd8j7soqrmizzFPgDvZGa4RSWwzkdu2jN6QPd+gH+oPLF+?=
 =?us-ascii?Q?sBBtpQmLggBMHI6kozp/8nRZkyFb//clKP/QEsCDAvNsogyPnMc8RUMnVVYM?=
 =?us-ascii?Q?J6lI7V9MmjPrz9wfMxiqc9T/gjUN2TTCOshqsvMNeUAZVudvVsfKEbM6wZ7i?=
 =?us-ascii?Q?9BIKZLggzHqOr5Bs3962aGkD8D4ZF0PH2KNHPODsG7XJ2z8tZxErOqY2gpJ4?=
 =?us-ascii?Q?hYtDotp71gdBfvYazWGuwXrEjQFyuDa85rCumA8dNNVEsCbJTYZAwnBpX+Vh?=
 =?us-ascii?Q?BO+G71uHEj44tRTmf35tQ82S0JbdmuNF8MHw31ToffNjWEx2938jHu7md014?=
 =?us-ascii?Q?BWEVxjj7fovNYShGDnDwMbpKr304kd22LVPzLmkvNwGalyjXSfbLSXyqiOn6?=
 =?us-ascii?Q?j133AVDEIiPy1PxJdKFAGXNabKladswQ2E4oha6rDZOfcZPLocvvcoFRMzmB?=
 =?us-ascii?Q?0BfykDVE7YV/lKWONvVczEzDb/gjJl9EEnVIiJdfC5GDIusLqYoOtxH/k8xZ?=
 =?us-ascii?Q?P4FJOLMPzUuXw2cutL6BuisiX772rJ6RRZ/SorHq870Fz9M8Z+7ytvnV8zsp?=
 =?us-ascii?Q?NR2eBX6HIiHtG5dtCSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5e1580-7298-4908-97dd-08dbd4ff54e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 02:08:50.8953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuWirfiNums44xriqhVH3KwtAYPn9LIsW3LM6PHLarDvTUlAIxISw7LYU5eNvs5ntHezKhT9gKRxLg4/apRmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

Hi Yifan,

Got it. This is the better modification.
I will resend patch.

Best Regards,
Ma,Li
-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, October 25, 2023 9:26 AM
To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm in=
fo

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




