Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF43C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 06:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6424910E590;
	Thu, 20 Mar 2025 06:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mKl53/dW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107C210E590
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTurIGGzOqLp3diGsnhTzKyiKmTLQJtNu7gnxZ+/6hiXIeBL3uOjcpIXtuhAZTgi0RfgjGMXHqS5XkL39Bd6EEm7FRhziaVVdpNPyRZiIlsfDyGA3KlgKDmm4Obfn/Ky3lSJfi1JrJftG7Z+y/Du/qleuT1GQEt0fKnyEYnWGZvS3P4bWFXiX1Fjmfvl9VDRr7dHwE3zk+7gchWaLg8e84WMCD8j+4sOShHYNL0wDoFJxvQvL6anb4f6EYAqg85Lc4aWoSgp1W3qGmbqJ4ICCjmMZVGZSH5eqdDXnJIldp6bfHl6oofnSJUbVOS3+3hjcFL+bDjigAAHTuJ3jOQC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWTmv6P4PLhZR0CX8cUEurk2Sj0DzSEwYdK3PlGy+PA=;
 b=tnvEwndhsJDpKWAGp0zn9TKxGxe/2Y3YUKgb4UmRpKeJDblLzJEmyNi6umL6QXGyD7n7znINo4v7rtTqn3PBOpu2AK+O6yVbS+2VQAcWtR6rmQOxUzdqCEmAeG9WCJutDlCabYXBi0vcYNhuLS4HJfUjVylWlKO0JZDU8BQGg1Xdm0tB40Ce3Q9BS1aQU5LxMTmOTEUz34qq9+FcX6xN8gzqjribUPEJnvgoIYCHswPGVdKEaNAlTUxtrfNooORGLq+1AFsdEhC+9VTt8bbLGEFXx3IJVCL4D/gGQ1Un/GI8hAlX0HczQ9UmCjAcelo+qGKve8/YHqhqf/IGggBy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWTmv6P4PLhZR0CX8cUEurk2Sj0DzSEwYdK3PlGy+PA=;
 b=mKl53/dWKCbC2r3KQWXaV3iYaIoSobuH8+helQzLzT1D7r4AuTkk5UrBo9jXtkE+kiTv4yBuaYxopk5cRUsRCjSS7GDR6hfUiJPVR29OTyBe7MkBkzYS5/NzVgK/qbQBNkZMWNVipjJJOO9PytpfeqgE+d5VlLSgRDEfyXasitY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 06:22:59 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 06:22:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Index: AQHbmV9ovGzWY8R7o0+NdJ91t8hqt7N7jaqA
Date: Thu, 20 Mar 2025 06:22:59 +0000
Message-ID: <BN9PR12MB525744C2A9073AB0999C312CFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250320061437.572914-1-xiang.liu@amd.com>
In-Reply-To: <20250320061437.572914-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=566afb51-5067-4ffc-aeee-7df36548fb1f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T06:20:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS5PPF6BCF148B6:EE_
x-ms-office365-filtering-correlation-id: 3d276541-ab7c-4843-f04b-08dd6777a92a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?j4u7/X/muboLg8N5EUntfkhjAe0kxBMT9PiI0Py8Qy5qHYtsxoi7oWwFjNW5?=
 =?us-ascii?Q?OFZpjM4bdaxEqjSkWud6wODCxpdkO3mFTnxX1MYwTs/VTaG0HVwTdQiwz2aB?=
 =?us-ascii?Q?0e0kvFe5vvKWdPod13v76T3TiWRf6Xta662Ye879DJzjzCKD+uRTqMEi5V0C?=
 =?us-ascii?Q?uc07/81cPUCd81WF15d6TzE+HAXeRLKYomO844FJRjugIzJX3gaZsfygy/jN?=
 =?us-ascii?Q?jHxQ81Hdemt3HQS/yMJo5IafgETgkwAULtyo95L9G7oEQCZJ3YKGf3JcbiNh?=
 =?us-ascii?Q?SNNVoUjGjZsUELUPhLIgu0FG84smLTylf44a8DmYCpRxJeBt2EQYOcyb6O3i?=
 =?us-ascii?Q?m/M9VBC3s8t1GJenuKIwJIyZgMqgTmhB+7DfwXdeBTnCGZT3WqWOh0CEBZTm?=
 =?us-ascii?Q?b/yEzVMvNWIrrUJcRO3Q87LDBJA4HUb0Ira/W6HjTnA9Y18tmY6lt3UWnpiT?=
 =?us-ascii?Q?U2PsTZcgZGWtrjFeamy75M3EAXyhWPD0FLw510Q4gnx+F79mkHRUnIzPNzB4?=
 =?us-ascii?Q?NXSSqk0ifmdcNBoS26K7uVsKNHS0GSft/rdalSt0bYqTLQGSX5Q+rjnDDP2J?=
 =?us-ascii?Q?xEP51GIB+em9kxJQvBmMGMsFpkvwW7gWyfcCj9iyd+1axx+bzX5qcCT0psiR?=
 =?us-ascii?Q?qVPhYlpTXpLlWMUNuWUCNuVpigrtdzjnCgep34TMpDlgo0ZsxjuzQYyggLu7?=
 =?us-ascii?Q?1p8rJkndGyNR0NdddUavY/gNSoTiyCpDOfWRyHe5PrDqpx3XzAsy5dQTGAZc?=
 =?us-ascii?Q?GtmFst4p94/qOQojHYt5PDSgMkDxUJCk/vrgKAkpHmCmmdpwqmSwZ2rs1ZSt?=
 =?us-ascii?Q?OPhR0l4SZvnDDMLvqAt+ao3M3+e4p7WKW417l2nkn6p64Din5agkf07WF9N9?=
 =?us-ascii?Q?bJH4dCM5qCJ22v8+ayxTpjtkIfC+RcE1VTYkhtCtxng9V5Kv5qHZ0xbaof+G?=
 =?us-ascii?Q?Sibr678WR0T8o0BztM0biHz2Fd+6nqx7/jiILWsEXP8EM37w5tLHA2pd6w5V?=
 =?us-ascii?Q?jznVNtEnKz8e4hAz4ZZJ59Z/ET6w0Hins55QJN/PTgYP5vc5P5LrZpc/H6PD?=
 =?us-ascii?Q?0OjmELl3qzXd+9alXPCSU7F5dVjwP0CcgpmE/pT5tcDwWh6pHzkFPVaamapo?=
 =?us-ascii?Q?gegCxi4hyccGNQ7dWvFNWEZuHyKqzpdeVsInM3n6jf2hz/MU7rZsbsfQ7s67?=
 =?us-ascii?Q?715/XBkFFBRE+F1M0RqZ6bANxO8iZhiz7VVIjaynYSJ7gaOlJIcDMcjMe/vK?=
 =?us-ascii?Q?t9i3c6ibMyezfsb1hiC+9VkoRTrrDyhwpPnw2tZYboMBcCMQvE4CuWH3PtmB?=
 =?us-ascii?Q?QIylCCLb3fte+vA0xIJ1zsfIX5u5gfvEpKzoOd7jGjZIN++9bysjNROjfNnl?=
 =?us-ascii?Q?PGoPMPwfd5kvZC+K823Z31GKsJbi0TwVQDuq8/EYJ+4fzkB076Ql4OIe7UQt?=
 =?us-ascii?Q?F7JuO1VkMwpep+3pB3vl+eplf5/tpGxC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+kaGcMcM2szpVlgc7axA7mcBJFKnfMksebuJOq8pdkOV7HDvSinpYcj9VGB?=
 =?us-ascii?Q?ATrjs1Spaa1qXoXo1UrVXKZ351HKxxBIEtDTPVOqN78mrBOOaLsP0H9xBccn?=
 =?us-ascii?Q?T49feDCXBxlL1dFvl9o0eoYK+aZlFb5dylG0Y3FDsmsUUeASVi6QtJXkXEwa?=
 =?us-ascii?Q?AroKMbaY5LySqSpEvy/UmdfhNv6B5DXfbv/OUUuLJYg9bVM99Oj0FiEjd8qy?=
 =?us-ascii?Q?wp+xBghOdCndyGSxSfaCARPsdP9CsdeT70G1jqtef6i/JKuCITHLuh3KRbYW?=
 =?us-ascii?Q?gRC53O/1gR5tEkkxZ4OcXn0DcrmLj1uMQ+M2m9iAJnHjVJMJZwXnFZLlr8tT?=
 =?us-ascii?Q?OUHYbpt9QGMJ+VWSe7ioRSUw3p9k21d++qUdxXiGTAP6ghmu2roSJBUzoVPU?=
 =?us-ascii?Q?j165GvbyjhxM040BU2L8RS7JGdrP6B7xkL8IdK5uIA4Bkf2VJ9RI09+r2W2W?=
 =?us-ascii?Q?dUYggAb+Rf4L7s+FScmScDQUBS7LsVjVSpil//q23Ys10ONx2cIBJYIzLnIE?=
 =?us-ascii?Q?AVA7X1jI1ImODHT2k1GNFvfHM5iXnWY/tLZa92C18eY4WbyM35uGQAXt+0hr?=
 =?us-ascii?Q?Zgvd5ybLNi9e29h+KRKj+E52nzzuofNZdeR+IA/hpFOofx+X3Fd9TZGo1pGu?=
 =?us-ascii?Q?uNfqoRghBt6sRRfJ9lNYPEHsYQXKBeGtb/shM9ekY0od81UwCpGyx+/KsIPr?=
 =?us-ascii?Q?1NGt9FWUTuVVm2PGYqeVGkbDFnND5wLjCKUG9iP+2XAM/9Q/kToc7ohZeWql?=
 =?us-ascii?Q?62vdtrXCcW4gPAi9uk7gRqkhTEIjQpFIUl8D0nO0RqJdK79kZNbHD3hClEZu?=
 =?us-ascii?Q?OfBjrnR9IufZWY/50cfoC0wIesnk75fJ/srUEfMQBwQQEJ6K1UCtodbkICEh?=
 =?us-ascii?Q?8F658rXOZHTmdPTPVjyzDI4bRaS9khGMVNHKMNCEvk/YkWoGGnGFmfeUl1z1?=
 =?us-ascii?Q?VfrLe15+3ANwcDiYdFiHg8nsodUExobRM1OWmezmAeO10ZxQ9HtetIAc7iFN?=
 =?us-ascii?Q?BqrPKkYNDZvsKjvxVOOU4MMQnISfoREQyZoXa+dTdSjwiy5d2sOTYoSYGFIb?=
 =?us-ascii?Q?Yg4XukpnPXvpjedgB07+AkQlnI+rfa4GYRGNjW5EUh6NsB3iZraJo8Q6kA+g?=
 =?us-ascii?Q?6nwjo1aKACLBaQeQsLCwxy9MNgDNr5ozyYTRoLOU1jDWoE4YDOA9ngCYCBR1?=
 =?us-ascii?Q?lSyXwT/6YSX+GAg6yWEXD4XnqzUASwaXPPahenqIs0IM+/gKv9H/PM5R4T3f?=
 =?us-ascii?Q?f+o8HXkSv62cJH8GKaYNSHigYJ8vAGhzOAxS05vS8722/HxDPelty4DjLIsR?=
 =?us-ascii?Q?SNjsPMLAeEsGUV4tTGgobbBG5TPLiJTRmWAJboCg25EZbQsKfWMdKKU/XWQn?=
 =?us-ascii?Q?Da1tgEWlPu65uOmC1aOBciRhQZE00tDYT7A3BLKx9idvytE1R1Z5p+DzIHFa?=
 =?us-ascii?Q?4A47MusycSIT4U2k0m/0tEG6YDKK1uOWI93MNgthzcazizREUVGYkH9nFm6a?=
 =?us-ascii?Q?dubdMJwn/cdpb2KUdTnbZgGP57am6v4YFRveuQ1DjjMcvWI4OSJN+MS1F7rJ?=
 =?us-ascii?Q?Wx+ftxfr7HEfyFkLFUi5LaKAVdLXGZMHZ2aw+P0P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d276541-ab7c-4843-f04b-08dd6777a92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 06:22:59.2719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9091P979jeN6fFhhxIQTuER1B3seVuCxh8h3YYEpeYDGmDWiDFiOfUNYwXenAfvkHk27pxOwrtKofrFQAzILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6
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

[AMD Official Use Only - AMD Internal Distribution Only]

+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;

Does it make more sense to create a macro similar to ACA_BANK_ERR_CE_DE_DEC=
ODE for above code segment?

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 20, 2025 14:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser

In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  3 +++  drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..3f45a600f547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        if (ret)
                return ret;

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..b21d784a7f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
        info.die_id =3D instlo =3D=3D mmSMNAID_XCD0_MCA_SMU ? 0 : 1;

        misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+       status =3D bank->regs[ACA_REG_IDX_STATUS];

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1

