Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA4BD0D152
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 17:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2659F10E2B6;
	Wed,  7 Jan 2026 17:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MW5frxMo";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229AB10E2B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 17:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d22/c5dtgm3Oc0ZRouHWB4lSH4GV31JPpYvJmfGgmdiBxOWisRdiqk6iVWwlCQFVL1/dJv8MVoXbwK4+wRBrx+dBVjZuEFpqQno1EXi2P6B0ZbBrn2JCSz9La/7hsYlA45XQAfPIWNKDqf/W57mlqbE38P5O+xKclWfZsM7sCgwx0nV5muEApgYqFE2VozAABZ2ahh3fmsjZCFysn+0QHN6QnZwig29uljrQEM36dGzWGjvFptHevPbNMvUj9Jh4DxzOD2WccphwskYx06woKEaM1Hd3hUtch/NnxsNNeqoPtQvdIw/ECxJ3zbQ/GW5HhFxZfjaAEeyRKVNFCwd74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+VJQIPjZhlfvqFF+My8M4TYwUMIIPicA5+U07JrTx8=;
 b=KLuSB3eg4FUxYWdhmucVaHMA4Ap5RHTq7wcTpAwCM+y8dd39VdgpXqqFXZOKikF5ZPCFcjSaQFplXXClfni2Yy8LZNVJLT88nQGnMMiDXMIZ7MjiD1nbYg0V6szu94Mpny6IdIOYRc/26uRARi65lLzB1PVvxtKMg2+w1cRZUCLtw3Z+cyYW1F+zJ/74Wlmlin49p9cqouHpX+N0DPGzh+vAMfeLF9dFS7VmRjj1TNAMRpyNfhc50irbmFE0ZH1bN+bWOhfj5vZgPhnLFKK8oWWTP1Y6JYvCL7q1okqYFZLj83WYHl+1OPkxipADMnKUXB1qYwxK175WPRaGeZYm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+VJQIPjZhlfvqFF+My8M4TYwUMIIPicA5+U07JrTx8=;
 b=MW5frxMovKGO70Nxm26z1gKB2pQ5bRENVK5DlyuyTavcwJP3oonNyRgpMdBNn1mzCKaUHJAoBdaJBkdKAz6XfO3MkST4/2wwA6ciXS5r1Pj/TfcKlYxOJpHre97j4op1Hdntc+oiHdL9Yii2BOe/Edd878C9hr0EUDtGrHGgBjI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:57:03 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:57:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Thread-Topic: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Thread-Index: AQHcfsZ6MmlZvNhH80+6O4M9QBUBSrVG/0qg
Date: Wed, 7 Jan 2026 17:57:02 +0000
Message-ID: <BL1PR12MB5898168ABF12D9D0518633D28584A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260106043927.51803-1-superm1@kernel.org>
In-Reply-To: <20260106043927.51803-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-07T17:52:48.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH0PR12MB8176:EE_
x-ms-office365-filtering-correlation-id: dfa29cd5-15f6-47eb-fe78-08de4e1629c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?OoldX1O+8qV+/ybypmKA9AZFqFY7D+dy0F0VRtM20NOvMGs3CdOZJzSFE+DT?=
 =?us-ascii?Q?gDIR6YxGTuv57anXNNMbkjjA8U8EkVhOZUqKcLb+uDkTusxOo80iRNEAAqUZ?=
 =?us-ascii?Q?ZPJFDx9NqXiXMLKZION+ai7JRaAekCfvTYl4b+kjWL3qDcaiSCnOttECt3Hp?=
 =?us-ascii?Q?rl1vBjgnSI0gSwdJlcj2LBj9JvhayrOyBTYbq2fvg/apbShrQq4wecmBvpns?=
 =?us-ascii?Q?NeGty6868n6tzSY/zFyhJKP3UrAGsuMjkxye/+7/XEdpN/cQQQ1TAMG5chrQ?=
 =?us-ascii?Q?Z8i0eiT4cXUTgDVCkfmD8Z7inBehOeaKvi1PZ7pHzwnFsHj9Mo+8pKW4Fgkq?=
 =?us-ascii?Q?UHcmQzpfAtLTuvsaUEJ2Iktolh16lD1KYMn3gkz2X6+PG7cHv1nvCqoueUqL?=
 =?us-ascii?Q?BoDQ88sI21J7PZRWId6T3QvtQpM1od0s0ul9mhh7+8TJ8OjfDf/HnBQNi2BE?=
 =?us-ascii?Q?ZSJPlyflgt3H/7rZmACB/z+P7BKU6Rn88LQhp0bN7VYORaDCe1aKDz0lcTwt?=
 =?us-ascii?Q?qkAjg3C/EXL4eq/4qZ3plkhd3Ps69BTM5jJM5gH3nUy5L0qk7JHSbOngjhdu?=
 =?us-ascii?Q?5QtNNg0zkuH2z3H0OnbslGPrnYfquwsjidGy16uw1B5lFPUTloS8X2M0xauF?=
 =?us-ascii?Q?H/o3e0GlYMJ3gQXeEQR6n9SLCW3A4T7llZH1Xf3KUBiLrzQtSQRllfF1LZY6?=
 =?us-ascii?Q?CZ2xPlVD1PN4sXFA+NwR8pnx0rUUTus1gkxa6pinx4g7FIFTokysqAaHbjyq?=
 =?us-ascii?Q?oRlBSSQ1v++IVa5CComlLmpjh3QaG6fnj/0a1AoXcC+eC50G0BSDtCi/Nvvq?=
 =?us-ascii?Q?WXnJj9WfmRs3lNqlcwUk/iuoTsN0MvoxL1vypjeRkVMZ4NxRv6Ddi8XtCufU?=
 =?us-ascii?Q?q91U7oFgiUZrj59DLfaEf+JSFFGxk0NBODWQcLm9UmR7WAulhFMQzxcZpf6w?=
 =?us-ascii?Q?kjjRiHwWGemtH7IHzeJdEooZcmPxgxoCGi/7pU1uHEt+qR6KARNhg5tKDIWK?=
 =?us-ascii?Q?uvS7h1u+BbYB+VTOtROybn7r5GFDAH5lUCqtUGwKy7+OqQFCcYgGdnyncJh5?=
 =?us-ascii?Q?0cEJ2bhS5UViS4Otkof3ustpq8MAo6KUzTBF+9Jxt8D1be5HNSyyndsWLA9q?=
 =?us-ascii?Q?5ZmGOEsoIFSyW40s4hhaL40rrZGuQ2ep05HsS1SjtxSdqFR05iENTb10l6FW?=
 =?us-ascii?Q?GwjY3kmMbymQu1FSmP8I5TM5tYynv4jtjmFfELAdbYR373+zpoiZzJG7FHP5?=
 =?us-ascii?Q?hdFTDPzZeRw0GuSG8GQfRGYX9y1mUj/f6XcLjSGx2Fd74X9YDAYySTVd8koc?=
 =?us-ascii?Q?nMeO2C2RjaxwqQiWrJoXwS+78IMc1+r9Q/wnwJwvRVrYiuI8EwcTbevA0Q1A?=
 =?us-ascii?Q?bbIzCJ4F1k+l4bhbUzvm2F40/jUKaWG7QEHUKOt/GkrM32j2RTDNlqY0Iypg?=
 =?us-ascii?Q?PjWBFxVDgQTADa9z8E7yE+HiBVyx05+/MJfC2PAMwq+2yZ59B/+R8wsJmmpy?=
 =?us-ascii?Q?nHEA5e4D1dwAvg9vJvxu7K+/RON+9u5Y+33h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kSU4bDvoA+SeD+Ol1Owqg5LE/RDer6ZbY5mpynw0zzB3FlLl57qRdF9rrgt?=
 =?us-ascii?Q?jk5M1+4nv6+0GuX79IK7UK3RQBrrBOtkPrL3RK0+5mXAUjMqqAko562c4ynK?=
 =?us-ascii?Q?EwPzBeaV3rwg3059PcKRjPpaKuOfEjnB9pAmu8ZLWNIwpzeg8s5oKTru4hNx?=
 =?us-ascii?Q?b+OM39qK6hVHUVh5Y/Q8405oDBvRdBGV6TIdngLi0AlaXbbvyca0ax/Lgq/n?=
 =?us-ascii?Q?T0hoWhxNMK0LCZR7jQoAfV6QrvQPaoSTeug3hc51ZcjncPulnHCSF4z0/XdX?=
 =?us-ascii?Q?7NbXhsnCZHU3BWCbJPDp8gDFI3+ELjo8kbHNHdZpHOizJcg2llNzH0bh26yJ?=
 =?us-ascii?Q?qw+CqI2u9YBSY0HNGRVjdshNm/nVQv6MpCOeGXRljgKMfRWUaOoXFgSct4AE?=
 =?us-ascii?Q?7t9Q+OreR9VgxaG1LGZioqNxOivuwENJ5wmd523ixJX1ifHItnEaq9ijRJaJ?=
 =?us-ascii?Q?P05XNkasrucw0ryyu4gr41uqAY0s0iBCPhdf7X6E4jlCmv/41ZTf2sRBRVM2?=
 =?us-ascii?Q?AwlxcXvHEcr38oL1T7qL0x9qN+qT+VINNlIlkvuksUd/6O8JtGuBUAKXvd6b?=
 =?us-ascii?Q?pCV4gYU0vmQRHtbOJ5294Gwk6XIXXykzUmZe7sn9dbZ6eIC06nhdJ0dNO9xj?=
 =?us-ascii?Q?1jx1XJZaH9wtcXJ1+d0IR23i7Q2diwczaGmM0MmWF2WMCmvr4uGU85BkY3Rx?=
 =?us-ascii?Q?1CpqYoqb82K2PZ2ee57uOYH95lTvuJaOwOp+wHIGsccB25LkX9Dkx1rUsbCd?=
 =?us-ascii?Q?a1SguVA0Kslhvn3YJJUMQ+/s4M16xl937Y6zzgHyvkv8R9aCwcw4oH92VPYs?=
 =?us-ascii?Q?r03Xe9IYFLMvC8bDcRK4rBe0fIvngSunVxOzN0y1CgLIgdDJCAOAW+Roi3O5?=
 =?us-ascii?Q?k6+RCfttI+Fk/4xvIPZVHjv/YBPQaIKRdQc76nlrun5tZUr57017dKaXrHrA?=
 =?us-ascii?Q?HswKVCi9vLxAlls/912rAnt8cK4wR+ffsAQWsHI3dp4Lxcm4eAF5/XF+2ax2?=
 =?us-ascii?Q?dKOwf5aOBg+cVsz92ECKFiUz0pnjVbUu3b/KBGB+dsLokldwD0X3UYHIayFT?=
 =?us-ascii?Q?NPD6YDJLuJQKUi3Ef4TLDeKlqw6nQ2okv0Q+TnzGM5fd+FtpI/ykLv2j6Nfn?=
 =?us-ascii?Q?epxnCbNlHvcR0MmdUxXuj8x/E2KM1nufyXOvmqvwQjFQzvSj8rz3Ggf9HvYn?=
 =?us-ascii?Q?J9A5znNn3w1WlvXhSV9h0mR728ZYO2Ug0qhMwZIPkhTBIF/vLuWXap5y+M9+?=
 =?us-ascii?Q?d8zsp6BRKBFvZAvsdTRX2N0y2KqgsSD794Aino6V45jnfqG9Q1npAkFxTImr?=
 =?us-ascii?Q?zo3xwx9/LLvjjJiC+TycPFUWpb0AhuANdhrtRgxruwgheHEqW3yhsQ98CieC?=
 =?us-ascii?Q?bGaA3ES/BDoHZXlGgq2qQykDVRtzBHgEV8hgPcdlqs17r5MmWFkCHhQogeAN?=
 =?us-ascii?Q?8eVD6MJ0jWwfuO4DoLCevDMwkgqngsh7JzBmQ4qgmx2LjB6EYsprv9uy564U?=
 =?us-ascii?Q?tNJwc4v36StB10Tt8hd52uqLofKLpBFvpkJFLWYfMoPqZU1Ko9CMfakF4CAq?=
 =?us-ascii?Q?ktDL0xWC4sMXI22H1I8BDII6+x0L8DfNTUOR+d+NsKqeNPcH/0UJRyTFievN?=
 =?us-ascii?Q?Af2pTuKLUrVYQr821hqEtG+ahU0omuMKh2kOm9HorUeqt4OMR2HBjgh4jujZ?=
 =?us-ascii?Q?77HP1YXuaAnwiCnrviF6j/ltTts9dkJTBxZXe8rOuhLToEiw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa29cd5-15f6-47eb-fe78-08de4e1629c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:57:02.9644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MY2MdF7uuLH9yculOEy3gAODh9aeJqOgCv9bh3zFqSfTQENcnqQRdKkfjIBhRKXv1muL9LTNSkwCAzRXoGv5og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

[Public]

Seems like a good start for the issue linked there.

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Monday, January 5, 2026 11:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Subject: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
>
> When an eGPU is unplugged the KFD topology should also be destroyed
> for that GPU. This never happens because the fini_sw callbacks never
> get to run. Run them manually at the end of amdgpu_device_fini_hw()
> when a device is already disconnected.
>
> Closes: https://community.frame.work/t/amd-egpu-on-linux/8691/33
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 021ecc988ff79..4bac0d25547f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5263,6 +5263,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device
> *adev)
>       if (drm_dev_is_unplugged(adev_to_drm(adev)))
>               amdgpu_device_unmap_mmio(adev);
>
> +     /* surprise hotplug */
> +     if (pci_dev_is_disconnected(adev->pdev))
> +             amdgpu_amdkfd_device_fini_sw(adev);
>  }
>
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> --
> 2.43.0

