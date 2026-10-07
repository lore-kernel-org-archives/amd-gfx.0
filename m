Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCDECA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 12:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7096210E562;
	Wed,  7 Oct 2026 12:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1PvM+bNy";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2B410E562
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 12:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F45tO/b3Soj07UQINWhaquDMdjUwPIt4vGGa4aZV0mu2IEI5cPD35X50qtnuSXARFtMv8ypZORziND3DgRXj0DGflue10oYOTHiX3ara3SXW6cVceq7kafXbMcLVlRfMr51o8afc8IGlQYIrE3QZbDy3Yr8S8L0CA7qZIux89g6dNCTihbChui+XNoXS6n7ntEoodqnM7QtcbFBbA8SXZgFfdydLteQtAFVo6qP1ctxigl8Fif7g6MXcSj8bd3YgEbbzi7bcGNXmxlxRUIe6GauicOBJseYqngY0eS4paxq23jEQgyN3KA/Ye0yfYOKdEN//sydMURzIQqKlBQWccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsNsEdLbLhnWAUgpoJNhd3MDQGZ4Sv+aUaz+i3pDHWs=;
 b=VdD893K/eYVTuaZuQrXmNENuBIR0/V7yM1ULg3crd+inn60AIEo3xIkX6PDKMNqgT+vCVhjKHDH4o8NVuxSER+YWYXA/SdpkfeucbFsOh/TihehM/vVdi0fNXtzPBWCvi1kDTQ+1mCwle3QP5Uiwu7n2cxBj6WUpXP2KWvKul6mntuq2+EpSWUBMpm3ZwRsVqVB9EGXKLXqDP0NpGQdyKDire1ls89u0J5TAlSfHerqo5d1Kd7nG+mWeS7v3tu5mrQiH1czP08WY8szMKlEVXE1aEQrLV7vlwoDWYNEhJTR1P4IJzqRn0eghaWVJIjxncj0VkqE6KNo5p/vPUtoSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsNsEdLbLhnWAUgpoJNhd3MDQGZ4Sv+aUaz+i3pDHWs=;
 b=1PvM+bNyPU7z8l2D4RRdg7qBcss3vUHZ7BE4ORZooZ4I6LSyPLZTxz+LrU5ii3LcrpeTjlliQZQvmVetmPHiK+faEeRjgpXLmnzNe50gp6qLnd6W6aWvWyHCxiTxMikG92q/ci9tLNO9DchiFk14RlR3Z7YClTxzWJwGLjuTOP0=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 12:30:00 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b%3]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 12:30:00 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Topic: [PATCH] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Index: AQHdStUiOF31PV6cfUOcybq1fmEw+LbyEzig
Date: Wed, 7 Oct 2026 12:30:00 +0000
Message-ID: <SA1PR12MB85990D863DDE337329A49A69ED942@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20260922205731.254264-1-luqmaan.irshad@amd.com>
In-Reply-To: <20260922205731.254264-1-luqmaan.irshad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-07T12:08:14.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DS0PR12MB6654:EE_
x-ms-office365-filtering-correlation-id: 9598502d-e863-463a-355a-08df246eb474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|22082099003|11063799006|18002099003;
x-microsoft-antispam-message-info: OHkjXS2IfUZP0gsm9/9UbEpISCCVejXVcvXtN3MQOUwU558HvXFgkyRmDQw1+R4tTko0xqnmhCoOS/lFbVyyJE/lr2LX9qyf7nyOhzrTn5v5iiDKjevW/jRdwNdv8G/yvMXNEUEJ/51RzCpHl197OPyL7Ws3aETOeNCwDlzrEAJibUSs4v2BdEdtO/nDIU9ref3fgkURnHaJ1OjK0kNBwvYpx5fvKjtGai5yKDWsN4QrI+Emj5QhgSMspgZzo2T2J754XbGJQNhsL6LfP3O7IoEo85Xb1fPQymyohxJ3YXAjJKU0QkEFqawTPpV01u/VWcbP5ZOBc3NfdwoK0fsCOGU7nQs6BlflfQ9k/N7Wt8f6CSKYWoCfvdRJDvXTaIJRlhOEGChEzm2ZrKRI+u059yjSYaFnevjrcZf3Hdl9skG/pF0K4RUELtRhIyAocEXsmRzeD/cus/+wWmNE5+k9mudF2fA5MIaH5DrGJW+f2sL//cvm3SR7IwujD71b/csa+Kkfqwxq3cdSnBsNJtpWfbmQjouK8+EP+UR23rh6209oNKjca4AsGiJ3t6EY/tJJoRAjb84DM9Vm8eQx0BUMB5rWhWeKTh74wEguoKAlEluOTOBcPFlqjKWDS+AxAEdMcV7+WDmEpWmqsbKjBEgO4SUcQnYuSCLp0nU0EdpBRdvtzATsYXU4Gj1mc0DsRi/DjLTLHI/PlFW3FL9poFk6dewJvl6qiBa7/x4DerkmXtU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9M1KZjbO3WZo4zkx8rck3jb9CGx0agZncDWmYZW1zDCx+2EKtcdDEnVvXc3?=
 =?us-ascii?Q?i7d7aKzrv9YtEHugNuCwFvBAwFlwHgt4Xuo+sVBL8oSvnLT7UUwusQfTQunT?=
 =?us-ascii?Q?ecElx7P22pwaD9tSePZ/6jyOTqDwJtuOW7GPFWbkjy9c5+9HcC36kk49DKkx?=
 =?us-ascii?Q?bZHICy1rZSfYlsoexsZOgErrJvao33pGOgmUJWgu0F2uvI/D2NB9vsYENPS2?=
 =?us-ascii?Q?F6cgUs3CdhIM2FTltCAgSv/f9fTDbi559knHAyEAbU1GYjYTwQ+ATJGhpfiY?=
 =?us-ascii?Q?SGj84L9MyzdXsgYxlgW5syKs/xLXPkU988pcAiikKXtQ4CH+osjChdWx5xRM?=
 =?us-ascii?Q?+XvJKqBN1gE7ne2suxhn7Yajs6vQEe80UX+Tc9TSfZBKnv1B3LfT5nPYrOkq?=
 =?us-ascii?Q?IuReChggoIucEzajBqFIMb5UoeBuW9FogvB6uZq4astdkgSJ1kBcMxlEybDb?=
 =?us-ascii?Q?ezWGiCI1qtnlnVPW/RW11l/Lc/ZfxZ50Se3rwbaCefuOMoiXeEzyS0EeTkR4?=
 =?us-ascii?Q?8kyH1xCAqT8GkyGdE7P33861mgD2rJyfw2jfeXBNMzu01hdT11lRJ02d88OD?=
 =?us-ascii?Q?cl3gnWbPSmeYgQ5LZFsno//hf/PhPoGu0CD7DcyP/oTNnY5j6DZy9bUK35vd?=
 =?us-ascii?Q?6VDM8NwHd6CZYR5WZc8YlVhg32ERGrNNQlLabYGFpJUAWWJDJt2m6yW2/jDN?=
 =?us-ascii?Q?i0H0zZv98mmtwk9Z8YmYpvU+C1xVeglWRm+RuwD2Mze0amdkI5cANfkaTx12?=
 =?us-ascii?Q?xYGea8QWtNb6uWzRNj6uBgaPDlEpKIbC35hkp8N9LDrdwleubHsbHS1PSabD?=
 =?us-ascii?Q?PYEUWhjSw2bOUYJ4bGeR5Of3DLHWMCYfXHlQ6SOI+9QRISt/eQ8lHLTqatCM?=
 =?us-ascii?Q?GCPgCuosK7cjdgFp+M9/ed0TfapPBhybg9BJ1PyUKlu7AEtUJGo5qWZ9OKX2?=
 =?us-ascii?Q?DftnAe86wCBEqXPVXf6NtJ7V4pzegOU3wyYQPh/RUpLu56boenqIu1gkXTsE?=
 =?us-ascii?Q?WbZ7ZZb6xmveaDy6/Es/UJxdz6GvZnUzVK5CTEpASE1n8sDojcdfNBdNEitu?=
 =?us-ascii?Q?pv1F5fcni7NTH1K4yQ3KkLLy8nSBnnDDUqly2LlUEpDfychA5va74qlt9SI9?=
 =?us-ascii?Q?R1nLTSZqZwgJo3zj23Ik2grnutrbcrrNRrUBqe9tY9P2caVe+ck2/B+BrUyo?=
 =?us-ascii?Q?0AEu9ct7GoC18H1uMM5h+Kk6P+PfPL+fpnFeF6/rzw74r/I/Iwm+oQyw11iL?=
 =?us-ascii?Q?GxCyx+VZdaCbyelmSMBdc/VoltC41pEVJQFhkr9HEMkY3pO4Kc4rD1jdlH/M?=
 =?us-ascii?Q?jvCxUZx8MhFXIsJfoxaMKj+T6m8m8Ls7xBTJAcfVDMAV/3KTtT9eBR23lVsC?=
 =?us-ascii?Q?B4xXADaQfs8iPtrroVRX9LauuNT0eIJnmGUmBLyJ6TzaO5rhZcJdvNuHW5ji?=
 =?us-ascii?Q?0E7VZxn3u8254ZDZFCPszJsgY1zmjnlcW0R8csoFZvZVrhLLwXBvDkMSqz9q?=
 =?us-ascii?Q?Bi6TQjm6jp3fEJHDKV3UHQdpJJYwkIrXPdMdmMQjhsgOLCVRDm/IyoCV9HzQ?=
 =?us-ascii?Q?DmGKZuF1L7eQDPJbWfeQsFhczYPmjW4+88m86Mf3H+C1/HUnVFMvR+2L2/bF?=
 =?us-ascii?Q?HBIqrS30vA2aV9EAtFBiVHBlYpgGgHXur9q3TzyoFKzuZfqmeArb2suW/O1A?=
 =?us-ascii?Q?ae9tk6YnZmqvu2NSQr3kMHiW7hn0d2BnD/trWo05M895oLya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9598502d-e863-463a-355a-08df246eb474
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 12:30:00.2225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G919PEmbyh7vmkO8fH/P+1AKNma5ciptLXEqqPzotie8xPVMvVxhwZDSgznFjyRqeoglV3AuRq+8C3k0mSMnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

Public

> From: Irshad, Luqmaan <Luqmaan.Irshad@amd.com>
> +     /*
> +      * XCP minors redirect their device reference to this DRM device.
> +      * Reaching its final release guarantees that no open files still
> +      * reference those minors, so the backing XCP devices can now be
> freed.
> +      */
> +     amdgpu_xcp_dev_fini(adev);
>       amdgpu_device_fini_sw(adev);
>       pci_set_drvdata(adev->pdev, NULL);
>  }

> +             /*
> +              * Stop new opens, but keep the partition DRM device and it=
s
> +              * minors alive. Existing drm_file objects still point at t=
hese
> +              * minors, whose ->dev was redirected to the primary DRM
> device
> +              * when the XCP device was allocated.
> +              */
> +             drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
> +     }
> +}

When looking at the final code, these comments seem to come out of nowhere.=
 These would be a better fit in the commit message.

> +              * Normally this was done by amdgpu_xcp_dev_unplug().

What does this mean?

> +              * The primary DRM device is in its final release callback,=
 so
> +              * every file that acquired a reference through these redir=
ected
> +              * minors has completed drm_minor_release(). It is now safe
> to
> +              * restore the partition device and free it.

Maybe something like: Since all the XCP minor files are released at this po=
int, It is now safe to restore the partition device and free it.
