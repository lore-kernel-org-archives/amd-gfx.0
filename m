Return-Path: <SRS0=zsti=PS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F8FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 03:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0271260F55
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Oct 2021 03:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0271260F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608446EAA6;
	Sat, 30 Oct 2021 03:49:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4468C6EAA6
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Oct 2021 03:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIjIrI9VnSfMV+AdiWqw631vgHjRa1u6x5hjVcL0a1rmlPpuJEyeT49cvleUfjxfTVn4TaiugPc9VgMOd3xwgpiRykNYNOCxM0UvjsA1iHf6U6JfA9bIa5NxZaS8MlD7BSZBhfJgzNYO9c2xajs5Z/lqbTOOnh30qtKvaV1EPZNQBLfL3ano7IDI1P1ltkfiIUamvxTjt9Ohp4myITxaigKxWVW/U1F1mGASdOoZJmwh6exYZNYUMc3bXV7CvS5MUvauHnVHR9ElZBBjPfFuuOXQtjYMK+8mG+MV1r0v/n1LD/kWRHiQ0d+XJQ0e8ypOGtNB3XxJVoZiUANcB7qDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CbNntvrcjSSBe//a8BPSNjopZJaarSfTryIOHNr/2g=;
 b=DBLCfL43zavqbK30420rv+8L7zkvH8EVAgC9+z2R341oc2NBjZJpf4oWph6kg32Enp2n3KUJgx8wsBMY9de98o1AHeE+Er5nKhjdPenOjTOMT3AUbZSoUc9ojS+hQ9OWaN+PVtGCUKYtE2ap7h7W3XTllt8RFDnoKkV8iJ5ta8L7c35I9d+4PbGJFiFoppCV35shNR64JHRCJgtRKPCgbaTgSdZXCAyFyoqr9oeDZ/vTWL6ycSH3YKLVKvTlPe1sdQXlqKwsEKElA6ey1zWMr2MFSj5311lZvab+4pH7DIa0IltfvXqOpc0wrAvA5zAts3TX9XvNZXXBq62zcIdYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CbNntvrcjSSBe//a8BPSNjopZJaarSfTryIOHNr/2g=;
 b=nFIYGpVXbLJI1UylJTMh4C0+hgMWXJaUsoB9OWRt+WrGsVl46gcvH/cU38THLF3h1mtbFUqMs92fK4HHmGSIAgWlWpRgM2mxUl0svZBfI/fQ2yOy8k7OjYh+lsoa5ufaFv3Eg1uY4OmM97MlR38wzCDDY2Br/WMoiDeXqTmpRWw=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Sat, 30 Oct
 2021 03:49:35 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.017; Sat, 30 Oct 2021
 03:49:35 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
Thread-Index: AQHXzQpiIf9c19Z+W0GxY0VJfXQSjKvq55ay
Date: Sat, 30 Oct 2021 03:49:35 +0000
Message-ID: <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211029211717.28519-1-mario.limonciello@amd.com>
In-Reply-To: <20211029211717.28519-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-30T03:47:35.0282261Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8d5bfb-9e2c-45d3-d140-08d99b584a32
x-ms-traffictypediagnostic: DM6PR12MB4041:
x-microsoft-antispam-prvs: <DM6PR12MB4041C8CA350D18726F0EE78497889@DM6PR12MB4041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3y4dpdMLjCTMV7WEL88YTLv+Irp+5pW7I8fU19h4UaXkz+jFYP0qh8QP8fKwGVvr/UOUEpkJNsTKIdomD19oik1UaZMhi3bOEmIg0Kq5mfFnlzaEcK6tFBXoVmbe2Q4Gk3fUAee/cvP6ZLuBYki5PrWQdnFyAv02dFJedyB9i8BP7PYAhDlfAKsnsI/UHAB0+ub0BoAeSTvfxf24lSq9Bps1xfyQ9w5hKV3/igIDDMsn8PE+9IrG/Q+vISWgf/q4WBLqoxSob84qgdwyRI/vUR2V92+OPZiCvNB+s5y44hrgekWimduyTaRm0oY326SvXxNOAVwC/SXGmVMDy/cUVjxqnYHo06SXWRsWv1/qG+fXGw2xtjVcrhC/XCPzY8IUd6N++YLm2xNXQ14Mzy3agrDJfc5LVCMk6mFhFO4cd7m1wcCdDOZRGcyxYLjETsWPnSflNsDlbczYWAD5D6cH0rUat8ZEvpVKQ6zySmdwFckamqD8pyrwxto8X5RR33v2m9NdtwHebgEJXUDEZKcgXSA/+q8riUSMg/gkor1IiNNpFdH5KZm1UZ3LkXleS4sqGikviDLRVwy1f1+lIDHxYlh9W52gEU9teBfeu0XWpu8CCjopAF3wJYPASZuVQEzE2tU4C4GadCiNK0r8haKXyT5+s+Sr3LbwLJ35ZDvlN7fskmGhu/TTau+l6ZHyS+JBCS2xAObjbNaVcAWmPeaxYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(186003)(66476007)(508600001)(558084003)(33656002)(91956017)(2906002)(76116006)(110136005)(52536014)(71200400001)(66446008)(316002)(64756008)(66556008)(66946007)(9686003)(54906003)(6506007)(86362001)(8936002)(122000001)(4326008)(38070700005)(7696005)(8676002)(38100700002)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eyLFfS5dViq6HV7VWjhv+ZtXIcu2xvdHpxG5uu4kH/6EULd+eDqkgidy7/pm?=
 =?us-ascii?Q?CjJLSYS5qFE8oxJAVDkOh3Uu+1AEtPikEHEnmvyrkywSnKbnx7XR8lQJVh72?=
 =?us-ascii?Q?+N9Kkmd6PNXye2fIGPBCjgEuZYVYYPsl036yaowvNqoIQoOtwgcEWYkTWVI6?=
 =?us-ascii?Q?eV5y82oxEfOFUkI4TVEimfM4qdxdyAriZzgSCvDA56TMmQZPL2yFhA+mYEu8?=
 =?us-ascii?Q?9KeFDvNcjrJq4lqdq+f8WoynoJezDN3Y5IbfQM/u9tPE/mq51bgF8sMYVsTz?=
 =?us-ascii?Q?vUx05WBBu3fiUXFSycmS86cMgbMN8DFkNzXOTlxBnlVBF2D1SHeeGKVEcC01?=
 =?us-ascii?Q?QB4CWjRe5v/zYCAQpPxDwn/AiZdwsWGdfmAMGxpcLKqE3WQPs6sp5qaS9jSK?=
 =?us-ascii?Q?9EULHLDssevXUT86iaCQnfIhVqdqMes/hpehFc0j917mQOl50qTaFVkREVaf?=
 =?us-ascii?Q?5CYwFA9s5vTSpqxBVR20LNMU/itNQ06IfG+eaX1G3CzU7evYTa+OgE5swN6Q?=
 =?us-ascii?Q?alHiDxTvB8/fkHgU5ToTfiy2kdjf2rUD1LX4520odXu2TuAowB5VD/FGHkHz?=
 =?us-ascii?Q?IY8fyZU12xxY3s5waa+wgYHavO+EKKTD3O+iUzP/wkROlDm+60VsBTyMRmN8?=
 =?us-ascii?Q?qG291ID598AeUw3cu3PZaMMj5Rn8DQJ/ZZf5PfWgBMOq2Ev1Li/K1aLSglMz?=
 =?us-ascii?Q?bBXtm+lwoeBTBBPTqxf7lRxsosP1q5NXKzFlJxNYgjtq6PbvKdW5glj+6BhF?=
 =?us-ascii?Q?4jAhA1Zs924P6UFsAfmhXlVGBUJDYacEhO7BhEM1AHCPiADpg8LWrKSaIRZS?=
 =?us-ascii?Q?z1Sf3Qyl25NfEXLGlRJMyFsFnQkQBWEanj9pCfKPJfebjtciY4HUmShl31Fy?=
 =?us-ascii?Q?BmcPHUDR+T+qNqdduIpr38wGQaSznZOHmIvcLyhMV5RePIQUgxDMbbIvI315?=
 =?us-ascii?Q?oRDecYy800rcyIqqRQksw0wSZu1hoJqe2BNhCjxIT4vMKupehS3Q+qMbNvvY?=
 =?us-ascii?Q?YQiwyZDQAKdj/ba0kQt40ypTE9X6awab6/y2jCV7qbveeDXjNxAZgUz21q9A?=
 =?us-ascii?Q?OH9PWK1J8Xa9xDn2vbRp5baEnZ4XHlsZsUVuJdiaEQU0/pzP9ifUsiH9VFGs?=
 =?us-ascii?Q?fXzwTUbDQUZBAUaJuIJGMC2abY3sni7tAgBmRboWCazziNigMG3i8PXRURd5?=
 =?us-ascii?Q?r7NNsSvtX0RSYgxnmGo3d7QWJ8yQWqfmxBsywKeAcp7cnUaLu1kf3mVdAsWT?=
 =?us-ascii?Q?iZ38awqoY0JxplolKeImUOWtIaPZYxshpAml6Q8Ni1nTsrhS6tHbH3vxflXN?=
 =?us-ascii?Q?jgHccdOu2uXXU2gYoGWNawAHnNACOojViLmvoPU9pGsK8w5Ui6HztCmxjFO3?=
 =?us-ascii?Q?tt8qSz045lmYjg+ajmhWrM9A/rXygZTpRAR1lKRHca0GKUI5YRHGjncLvhL1?=
 =?us-ascii?Q?mp6/0Few5h+wKts97sZADuKmkFoH95M05ckRIROK9pCHq6X52cAV4kAVJvDn?=
 =?us-ascii?Q?aV0Ri4qvUmugTpyvxEPuqdkH1I03A6gB9yRbL2MMHU4MDYevS0LrauPOb0ty?=
 =?us-ascii?Q?jAwqOyolcWmCsbNazX5gO31YEfk/RQrF+zCvf3hO?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB39307B878DCE0423ADFBBFF397889DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d5bfb-9e2c-45d3-d140-08d99b584a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2021 03:49:35.2068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBkkaQUnob14Xl+aEDBo3Pj2BXBk6pnrf0Pzo5qyIgH9/j4igyYuIfIdkdoe6101
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

--_000_DM6PR12MB39307B878DCE0423ADFBBFF397889DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Instead of ASIC check better to do the check based on ppt_func->get_power_p=
rofile_mode. If function is NULL/not implemented, drop the attribute.

Thanks,
Lijo

--_000_DM6PR12MB39307B878DCE0423ADFBBFF397889DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Instead of ASIC check better to do the check based on ppt_func-&gt;<span st=
yle=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px;display=
:inline !important">get_power_profile_mode. If function is NULL/not impleme=
nted, drop the attribute.</span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_DM6PR12MB39307B878DCE0423ADFBBFF397889DM6PR12MB3930namp_--
