Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B57606A33C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gDjvY/67
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAA610E1CA;
	Wed,  4 Nov 2026 15:14:09 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CD910E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1+KKbtWMSZfP8zoZaqn+JdYnbcJQh81qjWJg6CCt3xeBygG20lcuqg9fAXZUPoV5HYJQzgzb6dtxb6uedK9RoK70p3jtRBZlcpullPX2MZIQGHSJoEnCRlBXiPuOvWbN5mCUgr14snyfSUtGZ8AsKthYCh4jZ3CqreW1CVbDgEvRyHQmfoPfY65q8qaoCvKieft89o7o6uNFPpp+V/5xi/HervwNLGpf8ekM/lQzHFIgfk/YHcwjRLfWP0KK3dZU1MX1nLMSGHyyrq/ei6FrzEdOF/sDlpD9rqdJI0J7hZZdWYEQDW9tOXE96vn8aqb10dyfLsg3ns17xtcwQtMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12Bw+gfzxTWUxPHVTn8TSWCJ48h1Bf/I8k3NL8eqiBc=;
 b=EhGfn1j9wxC9wAPWk71FWVE6jgCISPxTGOxVa/NFNlFWfyzRsAtsEVD/xOFybdh15srkEHV+zjERRQA9cEHXpD2kZdT5DI0uGwZ24HeiDHuDih0LmE8vjKUNHCJayx8MZ4fmXk6vSKv2EXxFZDFqkm+4tpD0uvEVS6Yo0FULOoMwFNHreFw+FLwcSyQP1Shl+jUSLGUXQ8xztZ9mePk5Nnhg8YtaL2xFhGMmAUYf8mFB1EYw76utBxyqW3nkh6QIkSeLGyLpAZu/Fl1xeJ3Ob4rsO/M+cD/quhlMzFB/4u6q6C+2LPboLyuDoObjxo1wSZ0UEFJ0vvBmIUsrjYc74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12Bw+gfzxTWUxPHVTn8TSWCJ48h1Bf/I8k3NL8eqiBc=;
 b=gDjvY/67GYxqicNLskTZVlQetdR5Pgz+0otuVnPd2v6rWhCyCc1LrAnXqSLRzdOK9TC15NoNMEuImpBVfNdcnumFjk4JLCodLk/jhx6EB6Bq+snz9XmbBHG/eyUBK1c/MWcQt6e4x9Kj6Sxn1NN89Nm/nSIUzPo5xR6O+hq9rsQ=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by AT6PR12MB026552.namprd12.prod.outlook.com (2603:10b6:170:116::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:14:00 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:14:00 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Index: AQHdZ9BSLA5xcHDK5EWJ/SgTc/U/J7caNtKAgADYwBCAANvTgIACGcOi
Date: Wed, 4 Nov 2026 15:14:00 +0000
Message-ID: <SJ1PR12MB612191850F1E0392C85225F880682@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
 <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
 <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <4a704ee7-01ef-40e0-8256-d0321914d27a@amd.com>
In-Reply-To: <4a704ee7-01ef-40e0-8256-d0321914d27a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T15:13:59.691Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|AT6PR12MB026552:EE_
x-ms-office365-filtering-correlation-id: 36d04e01-928c-4172-ce85-08df3a86411e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261022075727099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261021121427099003|261026140227099003|10067099003|22082099003|18002099003|8096899003|6133799003;
x-microsoft-antispam-message-info: DOVSah1S/EumE6IgW6tbrLvXWRqw3Ke1dk1EkikjmaL8sBfUwcZ/lKGlyuw0cg71kEuFjsIvzlx3ODLgFvAoK4jd6B7d8vytthrDrc8i106ygCFTfxi/EpKqS7o8e3/Xx6u3ydas43qqvvFxcGGH5reH2snkDZtssuEQV9oTBydRehfds+ezZyjQSEDzzmN6dhmDbhSBGa3GbBhKOuE1t40QMOlLFZ3JNgtvz1G3MiwGJK1eudHFfZ+6sx3Z71sN6KMrLhde4mblrB2GuaRFuMwMg5CrDVuhG1soCtFOcU4rCuh7DBNbQDgStDl4j3Ys8+4yqN7ln4MKI8mq0lDVSaVYK8lP5GYiMXgDTh+x9Fr00L6Hs2R+aDFNaJuYyVi3znPq3FHB2Xw0XlWAa2NTzyManY9pOTlq5d1XpcD7TWTADfl1SUFjx+i8qP3duXIsFoRK2hVZqLyCMKH8xy5GYUPBKcrGHK8X1rFws4MtKLHSMRe5PJxuq7nEkJnHVjK/a+eMB7w+jtIN4tXBymI0E/JmfCh1dleKnEOuk2f/Bs0EdignGwB27u6JrMRqZVHsY2oheO2jk9b2sOGXzxWh4yTl9iiN3YtmX5EveJvyBOZS+ulp32pBo0wF63nIx/j6lsA44PZSVrSxficiJuUGgdpuBvoCMFhTP8+4Ohjy1NnJ68aWQqt2Vws3rk2y5OaTdyIPR/oVxvuRxR80FTY9RRUvhypHphnfI4UVoG3sjTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261022075727099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(8096899003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EqyMB/XJ4In6zHOKXx3nEzBakHPMkDZdv48sWQn1cYZb2mR3bZSbUcZ5Ls3l?=
 =?us-ascii?Q?hYLaKZZ5/+YbLFjJeRpH0i2vK+YHH/jbdU+if4gv7hArBX+Sbxu6NiIirEkS?=
 =?us-ascii?Q?XDSpTKtMmlkWiNTjyKmskuSj5o0+j7/IgWGCJvCcvF9BPLal7DXfwNV62vzB?=
 =?us-ascii?Q?b2DNB/9spRk94vtoMcItJw2/SaaJ/BYLz46kkNZ30ozHxGHb6U7+xMD33+8A?=
 =?us-ascii?Q?ijh0i7dIRWSoECIEz3ESLFuaRWjyYgb5pJrLT9koNgV31zYSjuQoIkcbWnRB?=
 =?us-ascii?Q?RBw/x1NwQyzKmFYl5eKCFxbZ09R0xULnNTD72ZhWe8pWqhEulcoCBUIXzahl?=
 =?us-ascii?Q?g4oKNeyfC7ODrOuTFSa2oSpfojq/MYGyIbJaaCFnYkTtoveK7Wf65KusT5ox?=
 =?us-ascii?Q?wd/DnowdrftJ6n/WlXb7nC0o22D69BKOM1nx41WxjeJP4qKRxY5eOtWJel/W?=
 =?us-ascii?Q?vIQzvExbattASfqd8AH1ayOIGgZrvrWkrNoCPfqXdI1WcvMTpPe7OLT4T/Ii?=
 =?us-ascii?Q?5EgPgfrEYbAKtuwgMfRchvh0hsKkwLkJaE4n+MN9MubNPKAEbJwEqStEqHkr?=
 =?us-ascii?Q?57VnsjQCMVmqk7FWWB/h3yGyXXZefnj/0KRgKGFi6Xi27qrqeEgS5zGDpErH?=
 =?us-ascii?Q?Jc8LQbV6n6h4JVMUpxweo7aYh8K0ZM+90y8HU+wXj6xMeNa4p6ihs1EblLuy?=
 =?us-ascii?Q?cnqn3DPP8PnGLX9nvMX5CqjYxTqUQWf+vhB8Yk9/7nYUBwvKuUKWBEicsoLM?=
 =?us-ascii?Q?Sv+nKjtqbivF6rYG1NQvti6k+BIjyiV6i5ky3YQbJJy+3w8k0mzWMz48JX7t?=
 =?us-ascii?Q?TggkduqEm81t+jud8WVdEt6Q60Ow13U9DGXd8robabUJ5FCg6M+fhugteM4Q?=
 =?us-ascii?Q?UNDAjuj8OaHufQ6tAk27rUCbO4XTOiII2x8FyJdibzvdoDcTojzryZz6Em/Y?=
 =?us-ascii?Q?W7I2gsifjBjf61ijXll91b4s5BThH4juIaOQiC6ijzVOzyMwf4gVouOdc7UO?=
 =?us-ascii?Q?xHOFzidy7LH7iyU+8NjUi0yM4fCTOnDWr35y6bm2x5m4SAeR6rY2L3FDWZcy?=
 =?us-ascii?Q?ZqBS+xCf+ozhuO2e+vfCaLYaPLjJ2Ie046lttJwZMJlRj7YRoXbFrpPAV+gm?=
 =?us-ascii?Q?tvFUn7z83et5U3TU5B823VvCBFbKCukA9z15JYhwuuZMtxlodShlOW8B41a3?=
 =?us-ascii?Q?yDIig9qe8nL7uyDbhhcttHZiIJxPstufpcZOFjwjTH6Ltc4aVEb8QL5T4Npv?=
 =?us-ascii?Q?FWj8/n+0BM8YzHy1rNNqrGen6zHc44r0WUc7VoPDawTP+Y/agM2+r3Em6FL6?=
 =?us-ascii?Q?QCgwDtxHedjqzO564tTXPVwsgPfb2AA/nbGPeXWhr+cwkJer+Zi9CSARGMIe?=
 =?us-ascii?Q?c7HF6vHR5QTJtWS3v8AfUa7KXIPDFUuF+0pmLrMj/mPLuKv9tD8HywH5D2l3?=
 =?us-ascii?Q?Hs2B969fsYjZKWb9awMaThmHpg34Ce0ciotRjIrdO+qxwyYylVgC4/wQN2+u?=
 =?us-ascii?Q?Ts1zotNHqCkPEtkLqU+yd4nEj8mEYOeXhUgXETN5vku8VTAHSbAV/KXev7HU?=
 =?us-ascii?Q?FkJrzaQqBm30iIF5uebSubWTGR26vdzzLLZkRAdjcdiUFqXfLbsW3sipNpr4?=
 =?us-ascii?Q?d5ytbqZrQBwIIqW76xR7O+sdJj5tmw749bR7DVLX2gqUsefNG6MpeZytIxK9?=
 =?us-ascii?Q?1OgW0EP5aDClby35PYTtCXodEg+vu1p+WMpYholGHmiA+2aH?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB612191850F1E0392C85225F880682SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d04e01-928c-4172-ce85-08df3a86411e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 15:14:00.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VSweebhcZB2CPVWKI1Z7U08eeS9l6v3Vm0utsV6Dr+fnqXBJBYKlYaS+GPQUFMChtqUkJwtrTughSxc28wuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB026552
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB612191850F1E0392C85225F880682SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
AMD General

+err_release_full_gpu:
+ if (amdgpu_sriov_vf(adev)) {
+ /*
+ * Release the access the host is waiting on so it finishes the
+ * handshake instead of timing out and FLR'ing the VF.
+ /
+ if (early_full_gpu_access)
+ amdgpu_virt_release_full_gpu(adev, true);
+
+ /*
+ * Mark the VF inactive so the later fini path does not send a
+ * request the host will never answer.
+ /
+ amdgpu_virt_deactivate(adev);

>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>early_full_gpu_access case also?
>Thanks,
>Lijo

No, it should not be called. If amdgpu_virt_request_full_gpu fails,
the VF holds no access as the acquire handshake never completed.
There is nothing to release and RUNTIME was never set,
so the amdgpu_virt_deactivate() has nothing to clear.
Jumping to err_release_full_gpu would send a release for access that is
never granted.

> In that case, this code needs to be changed to just return immediately.
> if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
> r =3D amdgpu_virt_request_full_gpu(adev, true);
> if (r)
> - return r;
> + goto err_release_full_gpu;

>Thanks,
>Lijo

No, the goto is needed here because we need the amdgpu_virt_deactivate()
to prevent REQ_GPU_FINI to be sent inside amdgpu_device_fini_hw(). In amdgp=
u_driver_unload_kms(),
void amdgpu_driver_unload_kms(struct drm_device dev)
{
struct amdgpu_device adev =3D drm_to_adev(dev);
if (adev =3D=3D NULL || !adev->num_ip_blocks)
return;
amdgpu_unregister_gpu_instance(adev);
i f (adev->rmmio =3D=3D NULL)
return;
if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
drm_warn(dev, "smart shift update failed
");
amdgpu_acpi_fini(adev);
amdgpu_device_fini_hw(adev);
}
it checks if adev->num_ip_blocks is non-zero to proceed with the device_fin=
i.
In the early full access case, it runs before IP discovery while num_ip_blo=
cks is still 0.
So the amdgpu_driver_unload_kms() returns before the fini. But here it alre=
ady passed
the ip discovery set, so the num_ip_blocks>0 and fini will be executed.
Also, release_full_gpu is correctly skipped since early_full_gpu_access is =
false in this case.

Thanks,
Chenglei




________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, November 3, 2026 1:35 AM
To: Xie, Chenglei <Chenglei.Xie@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang <Zhigang.Luo=
@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM aper=
ture is missing



On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
> AMD General
>
>     +err_release_full_gpu:
>     + if (amdgpu_sriov_vf(adev)) {
>     + /*
>     + * Release the access the host is waiting on so it finishes the
>     + * handshake instead of timing out and FLR'ing the VF.
>     + /
>     + if (early_full_gpu_access)
>     + amdgpu_virt_release_full_gpu(adev, true);
>     +
>     + /*
>     + * Mark the VF inactive so the later fini path does not send a
>     + * request the host will never answer.
>     + /
>     + amdgpu_virt_deactivate(adev);
>
>>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>>early_full_gpu_access case also?
>>Thanks,
>>Lijo
>
> No, it should not be called. If amdgpu_virt_request_full_gpu fails,
> the VF holds no access as the acquire handshake never completed.
> There is nothing to release and RUNTIME was never set,
> so the amdgpu_virt_deactivate() has nothing to clear.
> Jumping to err_release_full_gpu would send a release for access that is
> never granted.
>

In that case, this code needs to be changed to just return immediately.

 >        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
 >                r =3D amdgpu_virt_request_full_gpu(adev, true);
 >                if (r)
 > -                     return r;
 > +                     goto err_release_full_gpu;


Thanks,
Lijo

> Thanks,
> Chenglei
>
>
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Sunday, November 1, 2026 11:32 PM
> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang
> <Zhigang.Luo@amd.com>
> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
> aperture is missing
>
>
> On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
>> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
>> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
>> returns -ENOENT, which the early init IP loop treats as the GMC block
>> being absent. Init keeps going and dies later with a confusing -ENOMEM
>> instead of the real cause.
>>
>> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
>> point where the aperture is actually missing.
>>
>> On a legacy host the VF already holds exclusive GPU access at this point=
,
>> and the early init error paths returned directly without releasing it, s=
o
>> the host timed out and FLR'd the VF. Route these failures through a new
>> err_release_full_gpu label that releases the access the host is waiting =
on.
>>
>> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
>> adev->virt.ops, and call it from the same label, so the later fini path
>> does not send a REQ_GPU_FINI that the host will never answer.
>>
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> ---
>> v2: Move the runtime cap and virt ops clearing into a new
>>      amdgpu_virt_deactivate() helper and call it from the label. Drop th=
e
>>      redundant SRAT error log already emitted by
>>      amdgpu_acpi_find_gpu_memory_in_srat().
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>>   4 files changed, 55 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index 3ced5c18daaa..3b6a3d86348c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>
>>                r =3D amdgpu_virt_init_critical_region(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>
>>        switch (adev->asic_type) {
>> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>                adev->family =3D AMDGPU_FAMILY_SI;
>>                r =3D si_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>   #ifdef CONFIG_DRM_AMDGPU_CIK
>> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>
>>                r =3D cik_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>   #endif
>>        case CHIP_TOPAZ:
>> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
>>
>>                r =3D vi_set_ip_blocks(adev);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                break;
>>        default:
>>                r =3D amdgpu_discovery_set_ip_blocks(adev);
>>                if (r) {
>>                        adev->num_ip_blocks =3D 0;
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>                }
>>                break;
>>        }
>> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) &&
>>            !amdgpu_device_get_rev_id(adev)) {
>>                dev_err(adev->dev, "Unsupported A0 hardware\n");
>> -             return -ENODEV; /* device unsupported - no device error */
>> +             r =3D -ENODEV;    /* device unsupported - no device error =
*/
>> +             goto err_release_full_gpu;
>>        }
>>
>>        if (amdgpu_has_atpx() &&
>> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_COMMON) {
>>                        r =3D amdgpu_device_parse_gpu_info_fw(adev);
>>                        if (r)
>> -                             return r;
>> +                             goto err_release_full_gpu;
>>
>>                        bios_flags =3D amdgpu_device_get_vbios_flags(adev=
);
>>                        skip_bios =3D !!(bios_flags & AMDGPU_VBIOS_SKIP);
>> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>                        if (!skip_bios) {
>>                                bool optional =3D
>>                                        !!(bios_flags & AMDGPU_VBIOS_OPTI=
ONAL);
>> -                             if (!amdgpu_get_bios(adev) && !optional)
>> -                                     return -EINVAL;
>> +                             if (!amdgpu_get_bios(adev) && !optional) {
>> +                                     r =3D -EINVAL;
>> +                                     goto err_release_full_gpu;
>> +                             }
>>
>>                                if (optional && !adev->bios)
>>                                        dev_info(
>> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>>                                                        adev,
>>                                                        AMDGIM_ERROR_VF_A=
TOMBIOS_INIT_FAIL,
>>                                                        0, 0);
>> -                                             return r;
>> +                                             goto err_release_full_gpu;
>>                                        }
>>                                }
>>                        }
>> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
>>
>>                }
>>        }
>> -     if (!total)
>> -             return -ENODEV;
>> +     if (!total) {
>> +             r =3D -ENODEV;
>> +             goto err_release_full_gpu;
>> +     }
>>
>>        /* Request full GPU access only for the remaining SR-IOV init wor=
k. */
>>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>>                if (r)
>> -                     return r;
>> +                     goto err_release_full_gpu;
>>        }
>>
>>        if (adev->gmc.xgmi.supported)
>> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>>        amdgpu_smu_early_init(adev);
>>
>>        return 0;
>> +
>> +err_release_full_gpu:
>> +     if (amdgpu_sriov_vf(adev)) {
>> +             /*
>> +              * Release the access the host is waiting on so it finishe=
s the
>> +              * handshake instead of timing out and FLR'ing the VF.
>> +              */
>> +             if (early_full_gpu_access)
>> +                     amdgpu_virt_release_full_gpu(adev, true);
>> +
>> +             /*
>> +              * Mark the VF inactive so the later fini path does not se=
nd a
>> +              * request the host will never answer.
>> +              */
>> +             amdgpu_virt_deactivate(adev);
>
> Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
> early_full_gpu_access case also?
>
> Thanks,
> Lijo
>> +     }
>> +
>> +     return r;
>>   }
>>
>>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c
>> index 576a818db522..a4dd0299fe11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_devi=
ce *adev, bool init)
>>        return 0;
>>   }
>>
>> +/*
>> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed in=
it
>> + *
>> + * Clear the runtime capability and drop the virt ops so the teardown p=
ath
>> + * does not issue host handshakes the host will never answer.
>> + */
>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
>> +{
>> +     adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
>> +     adev->virt.ops =3D NULL;
>> +}
>> +
>>   /**
>>    * amdgpu_virt_reset_gpu() - reset gpu
>>    * @adev:   amdgpu device.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.h
>> index 3971bcc1ed11..3520af170278 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *=
adev);
>>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init=
);
>>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init=
);
>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v12_0.c
>> index cd276a138e10..3bb13cfed92f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>>
>>                r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_bas=
e,
>>                                                        &aper_size);
>> +             /*
>> +              * An SPM VF has no FB BAR0 and cannot init without the HB=
M
>> +              * aperture from the SRAT. Abort this GPU probe instead of
>> +              * limping on as if the GMC block were absent.
>> +              */
>>                if (r)
>> -                     return r;
>> +                     return -ENODEV;
>>
>>                adev->gmc.aper_base =3D aper_base;
>>                adev->gmc.aper_size =3D aper_size;
>


--_000_SJ1PR12MB612191850F1E0392C85225F880682SJ1PR12MB6121namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
AMD General</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+err_release_full_gpu:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (amdgpu_sriov_vf(adev)) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * Release the access the host is waiting on so it finishes the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * handshake instead of timing out and FLR'ing the VF.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (early_full_gpu_access)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ amdgpu_virt_release_full_gpu(adev, true);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * Mark the VF inactive so the later fini path does not send a</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * request the host will never answer.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ amdgpu_virt_deactivate(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;Shouldn't this be called when amdgpu_virt_request_full_gpu fails for</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;early_full_gpu_access case also?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;Lijo</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
No, it should not be called. If amdgpu_virt_request_full_gpu fails,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
the VF holds no access as the acquire handshake never completed.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
There is nothing to release and RUNTIME was never set,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
so the amdgpu_virt_deactivate() has nothing to clear.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jumping to err_release_full_gpu would send a release for access that is</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
never granted.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; In that case, this code needs to be changed to just return immediately=
.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; if (amdgpu_sriov_vf(adev) &amp;&amp; !early_full_gpu_access) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; r =3D amdgpu_virt_request_full_gpu(adev, true);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; if (r)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; - return r;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; + goto err_release_full_gpu;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;Lijo</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
No, the goto is needed here because we need the amdgpu_virt_deactivate()</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
to prevent REQ_GPU_FINI to be sent inside amdgpu_device_fini_hw(). In amdgp=
u_driver_unload_kms(),</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200); color: rgb(102, 102, 102);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
void amdgpu_driver_unload_kms(struct drm_device dev)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
{</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
struct amdgpu_device adev =3D drm_to_adev(dev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (adev =3D=3D NULL || <b>!adev-&gt;num_ip_blocks</b>)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
return;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_unregister_gpu_instance(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
i f (adev-&gt;rmmio =3D=3D NULL)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
return;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
drm_warn(dev, &quot;smart shift update failed</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&quot;);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_acpi_fini(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_device_fini_hw(adev);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
it checks if adev-&gt;num_ip_blocks is non-zero to proceed with the device_=
fini.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
In the early full access case, it runs before IP discovery while num_ip_blo=
cks is still 0.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So the amdgpu_driver_unload_kms() returns before the fini. But here it alre=
ady passed</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the ip discovery set, so the num_ip_blocks&gt;0 and fini will be executed.<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Also, release_full_gpu is correctly skipped since early_full_gpu_access is =
false in this case.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chenglei</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2026 1:35 AM<br>
<b>To:</b> Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhigang=
 &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the H=
BM aperture is missing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:<br>
&gt; AMD General<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; +err_release_full_gpu:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (amdgpu_sriov_vf(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Release the access the host is waiting on =
so it finishes the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * handshake instead of timing out and FLR'in=
g the VF.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + if (early_full_gpu_access)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_release_full_gpu(adev, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * Mark the VF inactive so the later fini pat=
h does not send a<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + * request the host will never answer.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + /<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + amdgpu_virt_deactivate(adev);<br>
&gt; <br>
&gt;&gt;Shouldn't this be called when amdgpu_virt_request_full_gpu fails fo=
r<br>
&gt;&gt;early_full_gpu_access case also?<br>
&gt;&gt;Thanks,<br>
&gt;&gt;Lijo<br>
&gt; <br>
&gt; No, it should not be called. If amdgpu_virt_request_full_gpu fails,<br=
>
&gt; the VF holds no access as the acquire handshake never completed.<br>
&gt; There is nothing to release and RUNTIME was never set,<br>
&gt; so the amdgpu_virt_deactivate() has nothing to clear.<br>
&gt; Jumping to err_release_full_gpu would send a release for access that i=
s <br>
&gt; never granted.<br>
&gt; <br>
<br>
In that case, this code needs to be changed to just return immediately.<br>
<br>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ad=
ev) &amp;&amp; !early_full_gpu_access) {<br>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<b=
r>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_=
full_gpu;<br>
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Thanks,<br>
&gt; Chenglei<br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; *Sent:* Sunday, November 1, 2026 11:32 PM<br>
&gt; *To:* Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd- <br>
&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhigang=
 <br>
&gt; &lt;Zhigang.Luo@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the H=
BM <br>
&gt; aperture is missing<br>
&gt; <br>
&gt; <br>
&gt; On 29-Oct-26 11:36 PM, Chenglei Xie wrote:<br>
&gt;&gt; An SPM backed VF has no FB BAR0 and gets its HBM aperture from the=
 ACPI<br>
&gt;&gt; SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_s=
rat()<br>
&gt;&gt; returns -ENOENT, which the early init IP loop treats as the GMC bl=
ock<br>
&gt;&gt; being absent. Init keeps going and dies later with a confusing -EN=
OMEM<br>
&gt;&gt; instead of the real cause.<br>
&gt;&gt; <br>
&gt;&gt; Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at =
the<br>
&gt;&gt; point where the aperture is actually missing.<br>
&gt;&gt; <br>
&gt;&gt; On a legacy host the VF already holds exclusive GPU access at this=
 point,<br>
&gt;&gt; and the early init error paths returned directly without releasing=
 it, so<br>
&gt;&gt; the host timed out and FLR'd the VF. Route these failures through =
a new<br>
&gt;&gt; err_release_full_gpu label that releases the access the host is wa=
iting on.<br>
&gt;&gt; <br>
&gt;&gt; Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME an=
d drop<br>
&gt;&gt; adev-&gt;virt.ops, and call it from the same label, so the later f=
ini path<br>
&gt;&gt; does not send a REQ_GPU_FINI that the host will never answer.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; v2: Move the runtime cap and virt ops clearing into a new<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_deactivate() helper and =
call it from the label. Drop the<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; redundant SRAT error log already emi=
tted by<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_acpi_find_gpu_memory_in_srat(=
).<br>
&gt;&gt; <br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++=
++++++++++------<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp; |=
 12 ++++++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |=
&nbsp; 1 +<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 7 +++-<br>
&gt;&gt;&nbsp;&nbsp; 4 files changed, 55 insertions(+), 14 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index 3ced5c18daaa..3b6a3d86348c 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_init_critical_region(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_ty=
pe) {<br>
&gt;&gt; @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;family =3D AMDGPU_FAMILY_SI;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D si_set_ip_blocks(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp; #endif<br>
&gt;&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt;&gt; @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D cik_set_ip_blocks(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp; #endif<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
&gt;&gt; @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(str=
uct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D vi_set_ip_blocks(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_ip_blocks(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;num_ip_blocks =3D 0;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(ad=
ev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
!amdgpu_device_get_rev_id(adev)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Unsupported A0 hardware=
\n&quot;);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENODEV; /* device unsupported - no device error */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D -ENODEV;&nbsp;&nbsp;&nbsp; /* device unsupported - no device =
error */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_has_atpx() &a=
mp;&amp;<br>
&gt;&gt; @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D A=
MD_IP_BLOCK_TYPE_COMMON) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_device_parse_gpu_info_fw(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bio=
s_flags =3D amdgpu_device_get_vbios_flags(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ski=
p_bios =3D !!(bios_flags &amp; AMDGPU_VBIOS_SKIP);<br>
&gt;&gt; @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(stru=
ct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!skip_bios) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool optional =3D<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; !!(bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optiona=
l)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return -EINVAL;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optiona=
l) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r =3D -EINVAL;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; goto err_release_full_gpu;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optional &amp;&amp; !adev-=
&gt;bios)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_info(<br>
&gt;&gt; @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struc=
t amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu=
;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt;&gt; @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(str=
uct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENODEV;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!total) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D -ENODEV;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto err_release_full_gpu;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request full GPU acce=
ss only for the remaining SR-IOV init work. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev=
) &amp;&amp; !early_full_gpu_access) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_fu=
ll_gpu;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.su=
pported)<br>
&gt;&gt; @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(stru=
ct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_smu_early_init(ad=
ev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +err_release_full_gpu:<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * Release the access the host is waiting on so it finishes th=
e<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * handshake instead of timing out and FLR'ing the VF.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (early_full_gpu_access)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release=
_full_gpu(adev, true);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * Mark the VF inactive so the later fini path does not send a=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * request the host will never answer.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_virt_deactivate(adev);<br>
&gt; <br>
&gt; Shouldn't this be called when amdgpu_virt_request_full_gpu fails for<b=
r>
&gt; early_full_gpu_access case also?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; static int amdgpu_device_ip_hw_init_phase1(struct amdg=
pu_device *adev)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt; index 576a818db522..a4dd0299fe11 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt;&gt; @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgp=
u_device *adev, bool init)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +/*<br>
&gt;&gt; + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a fai=
led init<br>
&gt;&gt; + *<br>
&gt;&gt; + * Clear the runtime capability and drop the virt ops so the tear=
down path<br>
&gt;&gt; + * does not issue host handshakes the host will never answer.<br>
&gt;&gt; + */<br>
&gt;&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev)<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIO=
V_CAPS_RUNTIME;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D NULL;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_virt_reset_gpu() - reset gpu<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * @adev:&nbsp;&nbsp; amdgpu device.<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt; index 3971bcc1ed11..3520af170278 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt;&gt; @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_de=
vice *adev);<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_virt_init_setting(struct amdgpu_device *ad=
ev);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_request_full_gpu(struct amdgpu_device =
*adev, bool init);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_release_full_gpu(struct amdgpu_device =
*adev, bool init);<br>
&gt;&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);=
<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_virt_request_init_data(struct amdgpu_devic=
e *adev);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_virt_ptl_request(struct amdgpu_device *adev=
, u32 req_code,<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/=
drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt; index cd276a138e10..3bb13cfed92f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt;&gt; @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu=
_ip_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &am=
p;aper_base,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aper_size);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /*<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * An SPM VF has no FB BAR0 and cannot init without the HBM<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * aperture from the SRAT. Abort this GPU probe instead of<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * limping on as if the GMC block were absent.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D aper_base;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D aper_size;<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ1PR12MB612191850F1E0392C85225F880682SJ1PR12MB6121namp_--
