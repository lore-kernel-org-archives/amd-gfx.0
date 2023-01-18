Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C1BC38147
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 14:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A847610E75A;
	Wed, 18 Jan 2023 14:46:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C47610E75A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 14:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDNdSStzhvCOFKSJ8WKVFvjdJ2llNGdLmZbyYhwFzkiJ5sx5V/FFYEIobc0Ckgk0L0SK2xej0e01ijJo6dUb50R0tlFEK2af2Gg5mg8fkMY8yGC6AMdELaSlD0dSimHKbkGsCT5F2fQwkCwWdf7zH3SG9iEePau3d/dux+P25EXT+CwK0x+aw4mD0q5XlPeKgOYAwbop+QcdP8g2cbJuUnQIYcajz+a/r6+ytQ7OXtTXWPyP8jWqQubDP82l8zwViNiyynqkInhLAonE1urR3BJt+KdIFvi73SxFUpUK6IbT9KceWDysJcT372RsIHLTI9dugyqdugCfIJ3EVuXEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyCCuJWwVrUC1++TpYp9jC63LAh4eHG79aO9zM201uM=;
 b=NtiXHtwJJlkRu0ZBfvtwASsVSnF/bcWJua+9q5dMAdhVafxbDpsItl6dzsZULanRK9bdDi1RSt2Ue7tdeTlP177zALutSPw0trb0ykX9s6RIaUSw8BDlj2DdGr7Q/5KE9QSfORBtoj4lBcoLhAWj86hxytQqE6bKwBQK7cQ7ou1ZbvdGIcLxzrXRZ6dUIUYtBgz5/+3s9PDgOeWo/TPWuxJLQCbd89PQBkwg3jHfVGEu7ASz2Y/ozi3SyZJoPavq49zdXwuL+6oi92YrGtJNBVKzahwUO7rfPnINSkrBJSW20Ponj9RxD3xZEi2PSM63sv4sJIXaLxr1dd4m49hn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyCCuJWwVrUC1++TpYp9jC63LAh4eHG79aO9zM201uM=;
 b=Ul7RhrJSYfK9A+MhA+6woFg1QQbKHWJkTnrK5dMHj3FXz//8qBC+Hcb3G9wOiLa46CC8Th7Z1y12d0UaVBtFqIujCj6AZ80RvTizSYcn54Dfz/9ItKJewDC3K/SVHTMjZmsUYNru0ZDVhBmV+P7RspgbfpeAPgx6dDGLuKrFn3s=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 14:46:03 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::764b:ecf8:c13b:7d33]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::764b:ecf8:c13b:7d33%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 14:45:57 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
Thread-Topic: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
Thread-Index: AQHZK0jq6XtWI+80MkeQhZJAoed1dq6kQG0Q
Date: Wed, 18 Jan 2023 14:45:57 +0000
Message-ID: <CY8PR12MB8193CEFAAC829BE2F5D4260B89C79@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20230118142611.1780725-1-alexander.deucher@amd.com>
 <20230118142611.1780725-2-alexander.deucher@amd.com>
In-Reply-To: <20230118142611.1780725-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a5b5b2a7-420b-411c-be3e-c8992df0bee8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-18T14:45:32Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|BL1PR12MB5030:EE_
x-ms-office365-filtering-correlation-id: bf709325-c2be-4dc9-435f-08daf962b579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iU9R24OB85f6S5wAhhASHSzWLspyP2MQBdDfxE0zQwbZ9YYnyxZ9VKhSvV+mVxn6lms2jIQR+vFAPRGRLvX2/FcTeKJ3r9JMDlwfHEl5Eb53CVCm0P1MXkt1ZBIZetd1kMl95IrDvpdfqOYR0uRuAQ5SkK3zo8LBmaPPJdTcPf/TDHJ9P6nJpDObWlRbqR44qN9dmNQc8F4ufCKzwg1FCPjS0HaNRJiACM3/D3s05DoIiFf6ajJTtQeHv1ZL8XDGOkdLLhWpkbJY62D0uFYOI8MkwUr2Vct6BWw0VgMiqg4NQPo6f8CMkSfrIX1ad5BphQeAax8s90rNNjMG42Pp9XzBna/SZGahEqrgXWNhyazWngJkrwbJRF1/A0EfrkSX7MtgDSqBIrosSBlgLFlKfF7sOr/QlKCRsptMyZ/icYigLoPqTlAmlJzRVgAJzvH1r35H1oRiNHn+Z8c5X797B50uwD9ZQSU5HvqB0vZw5+PmcVUbufNKWHHhfRiD3/D56lJBQVbxVJ+cCiCpZ0edo3csGjB5RLx6pkYC4XWhd+qGElLuBALz9dxCS6dPeiNDd3Q5rtUcVL5AiBf9B1N8Nw3N4bSxpBCTu7HDIFip9/EKWwmKsWDY3WFrn5AxFS5mglJXYe9LOCrsooHeTnYviBRFfDeZlpJWnuJRiYq+en5p+lXo4lu419+SULKnA6vgboPCRC2lB0YfbpuIOmXjuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(38100700002)(122000001)(38070700005)(33656002)(86362001)(55016003)(71200400001)(7696005)(6506007)(53546011)(9686003)(478600001)(26005)(186003)(52536014)(8936002)(5660300002)(2906002)(41300700001)(8676002)(4326008)(64756008)(66446008)(66946007)(76116006)(66476007)(110136005)(66556008)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lFELdj9W3XRFfIZ7l9JYp8eRvqn1YVkuKGn1ycO2iuxeLLOKpB3OqK7nwn/v?=
 =?us-ascii?Q?EsXHPxYHvZUm6AobCSdgcansoixhoboZXojaD6QFABnQIZDXAQCsepPAlAm1?=
 =?us-ascii?Q?zk8YZ13LVXdcyYy4w7yKVM5b3OvmjC2h3NBLKOii1UYiJlILSjG00HdlBNQC?=
 =?us-ascii?Q?mO9LUgPtm8yaOX51PMQUSTCqbCRPV/ho3M3YVz8vThwe2oUw1aGAPJSm9O2f?=
 =?us-ascii?Q?jO6L+d2Q6nHm97B2611t6oDR3tq5a7C4CnsptvKlXsXDeEaLYIyeOeEfoRjA?=
 =?us-ascii?Q?K9in4k3f4i2ZKqinAnm99Vuqppj+omsPt4eVXX4v9XHRFeKv+9pB0aDQgPw9?=
 =?us-ascii?Q?QbDEaCTzPQfxRnvRv1nl2aD8XcDxHRbcC7JCef9KQQftaUV4QGIjlP2Eqnb9?=
 =?us-ascii?Q?tdcinLRRBobdKJaKPonIVv0sIR2ql+mWh9FcklNBS8Cf9oUGbOYeLeBZLLVe?=
 =?us-ascii?Q?7hsggufmsPQVOVRi+1oDvaw3s0f+IVeQvX2Gv8tSwz+gjzjH+tEWcBmA8aVX?=
 =?us-ascii?Q?BC8dLG/HCSttlupB9xeQ3AiWJNScLFlKnrDOH5YvdpmxN8TxIWSIvAn8Smp8?=
 =?us-ascii?Q?HVakNeDuww1siyPxJ/oHVmF0wqRrKdj1CPrqB/QxSH2xW3DPD35Ci04ge6ox?=
 =?us-ascii?Q?Na3YekCxK35CKFROj9OR7TQ+eqmNV4bpHh2WFZOnOnQr1JFP9IsSABvQnkZm?=
 =?us-ascii?Q?8+tS7AkhdzI9QqNiiT3bu2PfKOq0GZzg7k1aXgWRZ0K3gTXYi4LKxanL4kOV?=
 =?us-ascii?Q?d/rcesJefrCKW8QyGBiinRgKLiHyh9GraLfrRWCwsQrCHOPMYOJypKXmllca?=
 =?us-ascii?Q?fh0tmPlVjXzRktCHDRiYzrcuIbRAWHWrjWc5Emb7ZCUBCmjtKRtasIdfGBH4?=
 =?us-ascii?Q?129eHKbuavCyxkJPZRCUU0IO26xHNFBz/EMG4zZOm+FeLfmOHojqLpqvVeA3?=
 =?us-ascii?Q?uNzr1j7xL/cGkdD+Z+BiALEHKj4RgS7l5TAWnhiNPI+sZzdejC3INnj5MFd/?=
 =?us-ascii?Q?qUUAlqAViQ3wOw6kKxSK4+UNArdJSPJlTWDQ/cxZg2KIP8do99D56c/xSk+v?=
 =?us-ascii?Q?wndkHN1bvOSfeh26Qz9s+nPLEeOjnnuXo/FYkWEhr1BMq3aq4iBVUQjHxB/X?=
 =?us-ascii?Q?4aTvLP7GrjqbU35/7hADKp9aAxA3NSTaXyfMPX/qvI13Wdy2zztoACeJ1/JX?=
 =?us-ascii?Q?qrCgpVBl35g8NP3ww8synhDardbgDU56l40YODY2XLnnu18qrRNYWFN/lxX3?=
 =?us-ascii?Q?wKT4msLPNA6LqXXO7JhWl/LYEUho4allo4VnEEnK16d2iS2fz9uUKKloU7EN?=
 =?us-ascii?Q?GvT0zUonW6KKygJBkw/MwfwnHwUTNPPDWeYPtKVLf9CUufhbdAW6tknZrf8+?=
 =?us-ascii?Q?JLpBRTyZ9Jj14WCU7JR1Tfdx3Uxr+Jnbp6qTPKR5KbBOuBpnI0yE+AqE6e0W?=
 =?us-ascii?Q?sMOTUKKca4AoOXlPMK1mtIXZ7i4zSCdA7amyVoRBEbmzv66P9P4+gORPgOPh?=
 =?us-ascii?Q?pZnatM9QASdKLxaO+kRMj/mTf28uXWMpx5EinPCrZmL2LLM5AZLlw7D/kRCe?=
 =?us-ascii?Q?w3a9XpP65rNIsF2LRyk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf709325-c2be-4dc9-435f-08daf962b579
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:45:57.2612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DX83Njj7NesjdcZAeInCTzxSKffVtnWbcmZigvApZBn80RJsn6vvtOGHWoR/hqSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Wednesday, January 18, 2023 9:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Roman
> <Roman.Li@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
>
> Causes flickering or white screens in some configurations.
> Disable it for now until we can fix the issue.
>
> Cc: roman.li@amd.com
> Cc: yifan1.zhang@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7167a7b63f8c..b8ae51345668 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1502,7 +1502,6 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
>               case IP_VERSION(3, 0, 1):
>               case IP_VERSION(3, 1, 2):
>               case IP_VERSION(3, 1, 3):
> -             case IP_VERSION(3, 1, 4):
>               case IP_VERSION(3, 1, 6):
>                       init_data.flags.gpu_vm_support =3D true;
>                       break;
> --
> 2.39.0

