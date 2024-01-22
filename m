Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC331C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 05:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4404210E4E9;
	Mon, 22 Jan 2024 05:37:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1869110E4E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 05:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUAHMfa7FCqIRvz2k4lSexvlfF+SBAZQz/T/y6KjuXt2IXmWfVjjRlLLNzqIVFByanLyZ5RcXEWh3C5Fu1fsy2uQhv9v8Bo3YM3I8CdOTH7KtEWy8Fga7RRyuK53lZnuygmMGsc1nMzRJ+KlfNFi3l27IyFUaA1MOLDJXgBct335wokOwN+XvJYwmHK3tXuw+as5wkaL47mwin67MZWVb5EJfzljRSnw4bPrwg+1927PP2y3pf7kgOx4s4wXNGncSmyoqdRm/JA/D3yGYYsf/7lki5r0O8eRbDTqEYQ8BAGO7ua6y6J2SiayXZVfvQqRh2Fb8yFMMi8Ojep5pGikGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfFgpVjYfS5db90AZcYWJD94rAMfnfCT50aj7cn3gOY=;
 b=IIYCIsb9PLbX6Po40xDc9Y6pVCUB/EumhawnoXh3PGQ86Q/ytkB4Mi2/tplA2qiG2ypUai6FVji3q7SnFfaG+U1hLRjQT5Qt838HHA94oFe4Jqus8nIge+SjuF0SAfZDopkl2Ph5n0gFPdU30/aUm5HRVz6vwhKv2opO4ydbpKp4OOyzNXTYAqRo+tQPpYtJ/4vgHF0ayybtlYCGnsqa4uCw79RYF3fKVgO+NIjLrX2oTnwtZ0XDGBN/zLtY2NzBTZZndnaAx969KMdCq/h8scpEfIAf1gn8FU88Me0+XP3barQb9It7nBYNBrUnVhLM+1hJiBWjY0FLstNDxG3RtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfFgpVjYfS5db90AZcYWJD94rAMfnfCT50aj7cn3gOY=;
 b=x4rkn1X11fRFb4ymwuozjdb+Cr4uaqb6Wmh1/XTYbBLcHAu72oP4cm4aCWpeJfJ5L8ylB/vTQAJDEPmJdhUGX+GWuKApan+D1FGXiF4NnazQidJFKefA01HIjC9taoTbtnZdLVDwfMZZMtBmQOndigE8qej5xzxlvKJu+8Mjozk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 05:37:25 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::941c:b49c:66e4:8720]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::941c:b49c:66e4:8720%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 05:37:25 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
Thread-Topic: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.
Thread-Index: AQHaS3tEi9SFxDUoU0iJkMkPuPNVWLDlUsXg
Date: Mon, 22 Jan 2024 05:37:24 +0000
Message-ID: <CH3PR12MB807436B4D2A28EC22595AB52F6752@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240120083220.1804937-1-yifan1.zhang@amd.com>
In-Reply-To: <20240120083220.1804937-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e371ddaf-8913-4393-b3bf-8cab00a0a2b2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-22T05:37:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CYXPR12MB9426:EE_
x-ms-office365-filtering-correlation-id: 9291baea-4ae0-488d-b0dd-08dc1b0c369c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xCZEj8eKDiXuEFJ6Rn93Irs5tzFRPC3W4Q+odP4MrlKgH8zcJsGYLVV+4FQsVOTeBK83zUQvC/VB+jp+FC52C28ePBb9BcEl1RtAsumUkCCeOdb0bL4y1BMojpXWg1ixZQwkmpVJbH1RJBBEp9kl6uygY4Q0E/onHYmLYYR0iKOMLgg7GSCw0SF18mWFbi+mmgPlQRjcMZQFVIwm/gg/XlSG/E9AC0+mQmQoKlFzot2ekxWjrU9cEwzjsucPdM0L6oqBt0nPvz1xdUjRJNm5YBvt4DINRtbHu+d5a+c7mxgc5D9DjbrC244vOCsvakxJZQQkz/l8XZGzz31C2Btle2GkuvZ/N9g4KnhVdGl1KqtwO4bMfozERjXZmE4S3yUfepXROvFdhlscFom10wVZ1krNQI9LH2wmRuOpUACER+TETf9pCi0/eH/TOxXthQ9sdPi59VIn65AVayMB0EM2lAgIUkf4sqre4tTt2N1qP1C0cz/uRLabt2Oh4nlE3O/DLK3hr+yUrUHxn0kU4cSG+9ZyCZ+RGDYkp2WpWAdsr/IrsjkQADicBFc6XKIw2K3oHm9Pfk3Vy/p3BMtQyEercStYqe/c5Wb2L9js8pXNi8wCSNu+/BL29S0r6hhO5vp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(53546011)(26005)(38100700002)(122000001)(9686003)(4326008)(8676002)(8936002)(52536014)(2906002)(5660300002)(478600001)(66946007)(6506007)(71200400001)(7696005)(64756008)(66446008)(66556008)(76116006)(66476007)(54906003)(316002)(41300700001)(110136005)(86362001)(33656002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gw/XSDikEapEZ194WXZq9kWswiEoIuhhm4pJY4G/64uwNKl+Z0KyOkItNnN?=
 =?us-ascii?Q?JC7/cK0V4PbJF4SHOc+cd0GVGsbAXqTvdDkSZRVChUWI50mzV7BV0fQLy963?=
 =?us-ascii?Q?3x9jS3G2cgiV9XXnIwrNaS2kPIt1lyfoRN9CA0FS8kXKq9+nbqGGrrLkYZo0?=
 =?us-ascii?Q?4W6gQMXcsWmd5bwTZQt4xt8WfbWL3p2MjTM7kmZVEX/UNU4u12SzyjAGlTA0?=
 =?us-ascii?Q?jj1tyIgJ78Na19tivyDBc/dZn6BA4qy/5w1+5p+MfMT6RyVfz7Bo7wBSuyD0?=
 =?us-ascii?Q?w41BjDYntmGzemlnD3i5berko95GuXA3lnARvTfGtOPa/v+yNkT1Kzx5vrRj?=
 =?us-ascii?Q?XX+Fo6bsKuy8wxY04sMi8kkaiUH0tM3Z323Bj7/ht2vkAWgYIb554+bDnb4J?=
 =?us-ascii?Q?CL0a1mb8frtlASl4Qnbqgt8Q2/nUXD4R41V4bmLVJgpJhIKHTB/4XVhz6YLm?=
 =?us-ascii?Q?J5reuxL5qJi4AiccR85n6SQJGax/o//DvMjtQX+FUL11cq5aJzddfpaptFHO?=
 =?us-ascii?Q?/jdVC6SxdhqAUha4AK+afGeQRvsOz81UyR81LnyFC7hCh3WwAi5Gmirwvm8t?=
 =?us-ascii?Q?mdKcxindGtFFcn2uPRmutg4jmYbfxZYEyeqeor44Y2IA6b3Nplh1fstnuZxr?=
 =?us-ascii?Q?ZcvfpRzn8nrz54n/nOlB1cSV0MqRxfNFiyp+S0JNM9sEueIC7WYTlOIULVuS?=
 =?us-ascii?Q?gwCIb63wJgpJsZL4+9LOFli0uanr51SeqP746XkA6DAaDEm/gOInj5pkuQrD?=
 =?us-ascii?Q?X1spOL65fn7tz1r2MC6j/pCB+aefUiUvrFhOh0aPly+oBUic43XA+00VWd2U?=
 =?us-ascii?Q?KYnt7cGMPs2AU3QUIA/5H7jcH50s9u2yn9vKwdTvjpodwKldCuqJgz+UafRp?=
 =?us-ascii?Q?T+weM9FIAcs8i62oQ0Kb7+ZeVGNzA6prWWbnGNNRK2T7MfCmvhkevfQI6iAR?=
 =?us-ascii?Q?1aeAGrMver5Uo0NfVEa0qEPjpHHWDnKGL8S+GhnsbAzb6+7s9TVdFPmnCxY4?=
 =?us-ascii?Q?hczRt7cizAHRTC5r9c+vzujnMTE4WYoNL00fXTN30lSgwRUbk/fZ0iO4h1qp?=
 =?us-ascii?Q?M4y53XeuveEcMavt9BX108nAOKzQg0oeN+9nmUMkh/TAcjE1ArZexnbZ+8ld?=
 =?us-ascii?Q?Hi7RKprPL7dTUofxdu5WTOZmbBIW8BYslIuSdqqkE4ONW2jNaI9gxNmF5VoV?=
 =?us-ascii?Q?/QVKgQcXLI6VroiHuempkysLhvZJyvevbQQjZj+qNRRfUpwDVwrFWvk96jhf?=
 =?us-ascii?Q?Z+nU4ja/oHa10oL5DTJotOxiHgCKN9Q0x/pHqFmH6HNAed+Iavx9wUXyYuZL?=
 =?us-ascii?Q?BvN6QVVp4ri7r/3EKGUlTffTyLpLdm0fHlyPnfI38GNYcpZC/OBHKaH6rncX?=
 =?us-ascii?Q?4TsZxeTOPuFbsh3YRGrIYe0WgZtdrceeAPS0MDs8xtGa1sHN3sM4v0iN/Qq6?=
 =?us-ascii?Q?vvXb8Stvds++/gyOrFIFwEQntpqIuN3cgrqprAhmWdXyE7ZAstyEAN+ehqRI?=
 =?us-ascii?Q?7prwtI6cO+ATBEZy5MNqpDe/+4Hgsux8sGWUL67wcuH2rHCJ1KP2M/E6TuhB?=
 =?us-ascii?Q?HkKVlf9adjf/fNOjudQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9291baea-4ae0-488d-b0dd-08dc1b0c369c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 05:37:24.9183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SY0kr8HGZ4F6hYTt1mdPoVWHbZeeIlIrWPbAyT3so3y1biuCl4HLaLnwgzw1NReO9LFDRFx4bpGahika7t++Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Saturday, January 20, 2024 4:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li <Li.Ma@amd.com>; Zhan=
g, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove imu start dependency on amdgpu_dpm.

IMU starts anyway when dpm is disabled in backdoor loading.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index a2d3cced8f19..c5b1d036c95d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4324,7 +4324,7 @@ static int gfx_v11_0_hw_init(void *handle)
                        return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
-                       if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+                       if (adev->gfx.imu.funcs) {
                                if (adev->gfx.imu.funcs->load_microcode)
                                        adev->gfx.imu.funcs->load_microcode=
(adev);
                                if (adev->gfx.imu.funcs->setup_imu)
--
2.37.3

