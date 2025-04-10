Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8165C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 02:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE3710E354;
	Thu, 10 Apr 2025 02:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gE+5ESoK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A6610E354
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 02:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQo+ZMKAM3i4IhpO3uoKD3ACHMUOtaKlksTsPW7ZSsRYYz+QQTiDU6M2HF3k39sP8vMpEgKBGnCTEocfywS6uPZ4gNLRs5LAxp2QjqKRcVsETnJlaoI0K9XI0bbbbsok7suPX2NIdCb6deZxLdXB4kOgW5MBuXtXWHMHGyT4Xc+vK9W4YpW4b0EFJHbUOjO4iHM+KgflQx5U/EP7YsLvORO31f+S3rRM/upWeDXCjgGSb07quNLgl/qhXWliSCQTIOSYZKzJWpt06RzrqhSlE1O2TL5TcHGoI0F21MGmqO1te+hCAne8PyTbp1ziSO3ag1lQX2iU5bi0LSO66a3jBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12HSfDoeUygCbyexhyZEYWnt7ZsscbsVruh9Riof/hs=;
 b=U3cpX0Nb7wYNd1hVZZ8H6EaIbqXoeIUQwQpQFrLlS7P4hNN3QP4w/DZx5lP9L0f2eucmIAxNy/sMLEkUYhnoHP7skWvFI530HH1fnhDSEXXlnWq0tD/RG7G0RzOuUcrJpa0Uo/n0X8NyrXI3ps7VVeVLOrgsYrVQIVqpgP78kSOBxmWtznmAoBF4GBKoXLq4y3MqKMKUl/+cAPMHPiMObqqHIIOw1IBnc3WAyvF/lWdIv782PuSshsVd26+dFsugWlulqw/A9Syn+iIvTUmTaABv+qCQjOe3CdTmz8M/9JLIqGxiPbM6LZiH2xWAOMzIB0BJFIefWe3OBTSM+Wqgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12HSfDoeUygCbyexhyZEYWnt7ZsscbsVruh9Riof/hs=;
 b=gE+5ESoKPC4KcSUfF6nxULOurUvZymE5V4u/nHXRaX6kzavj+kr73iQzST1scoWnItY2CvoXDsQ84JPdOebBYRjTcnbJm6gaB3JgVxktUhFwRszGEnRJLdsKtA1XJjmpiHvkTiUfqmXSOa2RYDNL3FsNvFWHozlpHOiIyqxKzCg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Thu, 10 Apr
 2025 02:02:26 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 02:02:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "Sun, Ce(Overlord)"
 <Ce.Sun@amd.com>
Subject: RE: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning in
 amdgpu_pci_slot_reset
Thread-Topic: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning
 in amdgpu_pci_slot_reset
Thread-Index: AQHbqUhi0mGJtB90ZU+m94QVKHhEALOcJpng
Date: Thu, 10 Apr 2025 02:02:25 +0000
Message-ID: <PH7PR12MB879618BC3A9269589C170670B0B72@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <cover.1744200284.git.cesun102@amd.com>
 <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
In-Reply-To: <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=352c5b3c-3033-4ae2-ae3f-99085f9ad785;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T02:02:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6195:EE_
x-ms-office365-filtering-correlation-id: a66c1aa9-6202-4415-7479-08dd77d3bd99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UDb3+oLy0oZA348NSABv2f0aZwlSUG4dlawOidZ4WfGxb0ukMMHqU8Aq+5w8?=
 =?us-ascii?Q?I9T0s2LhdZ5eTXJF0gDO5E0DkZWMQnMlB40x4tic2MCoBjtilLvvO4lWN90e?=
 =?us-ascii?Q?5cV6val3MIFRA9IIVCOqehtodKfao967jBvhrUoFGQyomyonG3l4tEpqPu6Q?=
 =?us-ascii?Q?9L5p745ysaLJW3G4t7ZB3AQAv3BEc/I/xplzUmAJ00QpFusSsOOHRKiqwDtz?=
 =?us-ascii?Q?dqhC42ochXfLABh4VZ1Vcb4ombDcq1LXIpC0O7A3nJ+49/Rib74ftE5kxlFN?=
 =?us-ascii?Q?Hlpu5a+XuE67p1oc06RelNjonplC+HmAeXzXJT2bMmkJ0x4nwprqgE/oVrXV?=
 =?us-ascii?Q?/UDontJ+OLSwxYjREzD5sCFiOWdNNVUb22jWFFQW3+cRgJcWxifwT/Q5xPAS?=
 =?us-ascii?Q?87BVoFrf9mrJ5z9P95fNS97DbL8IcMw/spp4QtPCfHomMEC/tHXgNH9E6DZ+?=
 =?us-ascii?Q?jakyP9/d6rEwX86p3BXkgervDHx1H9hcYfCv7m1vqXAI3B4QyTtj7srtm8dv?=
 =?us-ascii?Q?nL2h87jgymy/ShmuhC/8nRiEcdp2FEq6NsVZE1qtqsaDZBxexT1jzbTpVM4+?=
 =?us-ascii?Q?Dp4UGy4qFJFsTJ3c/vmGgHW/qSJgiyMO16Rqzaw+FlcQo8ikDCyvwq50DPHI?=
 =?us-ascii?Q?48521xNNMeqxIp4yw/qqU9h6QdlI/0KQup3aoXRBtdeLRBaMV+CUFmngjEWP?=
 =?us-ascii?Q?HWWzbbha5l4/st/tSgu/8mfp4bvaRgk3HB3ZxPhULyB6iOC6MPhm5ZnLzQtB?=
 =?us-ascii?Q?RYftZVplnhPjMDGybcTvo+pFwJ8dRn9sck+JFICuiDmDU927WWhhhrQMnNIb?=
 =?us-ascii?Q?g+2iWfB8K3FiQwzwbaP3+yQTzaV7w1vvMs25PcAhffzxqr5NkJIoaKx+p98t?=
 =?us-ascii?Q?PDIX35ynpI1MDp+JYE8OEjfgWP+mIazBhZ2zAnJDTf1TMvZnXUyqpALNln8f?=
 =?us-ascii?Q?Ph9QrBf/9UfvfgyC3U/3lJS7KhskSy0+32o+Mvts2j7i4J+UeSuRDvyjNQTj?=
 =?us-ascii?Q?Fmw7R123zE8zwCZJHjisT91XdS9zEb+17gRJni+ADhEPfzT5iixXkbOq6AjK?=
 =?us-ascii?Q?91r9cHbTZVG6XQhAqHTCtGeuetZuDmwFMBLwQueeD8/9VskfLT/kFyXo14l5?=
 =?us-ascii?Q?WdXi5srxY65/+2erJMEh+KQlkiSSwKd9bSegYIv758ygCQakgfkdPlRsThTL?=
 =?us-ascii?Q?caht6NzcMbkb8vFdLQvCgJeyCtlbVTegtnhUXTd2bQHPG7bKt6OFVq1m9YVS?=
 =?us-ascii?Q?4jXxYUCWLw02F7OVbDJy+TJFVnGdvYIkyUgdd/TOSiRfa+UhgbnJAl/F+Mwv?=
 =?us-ascii?Q?e/u7+jCjv/ywAItOie91so/rJEuu7vDVs1EGbB9gnaoBSm3bpmwOydiM8TeI?=
 =?us-ascii?Q?DnUyeJ7O4Gj4PsgqcA1QYzxV0Q/2H+DzpGNGMRJGdy0DK0bAKo67itbvbkVd?=
 =?us-ascii?Q?6XAEGEcdE9+YW9A56eQwavDqjWJ09wtqYPV6h8ldkqMx/ZUw66lmMhoJBlio?=
 =?us-ascii?Q?X40ypLFbDrT87dE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1ApWsdH13xQus8IWAhn38gUqq1CrKHPhnnfJO4XNQ8KUkZUunJM/mNdW+b0?=
 =?us-ascii?Q?pIYEnCxhrlzm7xhvB8TobwZQCR8kq+oS2Leazh8BFvtgS6AT94N/yIzlIlb/?=
 =?us-ascii?Q?iyeQ9gNmMwrRy+ZJojyr9dw2BgjzE4njyJHYTl1Qf2DhD+Nm9Tl9zqTE374l?=
 =?us-ascii?Q?0xrneVr8YGDxLWpS6diakT1uqe6QaVNmY+y0NkNFbRnr71q6hHYF4JGNrVm6?=
 =?us-ascii?Q?WWO4J+/zInkvqTDZtGFGjv/wENGfvY9vtRWfpTIVD8MnCxXL9bfhsDL6gDyk?=
 =?us-ascii?Q?/J7wVBTlVk/oQLKU2XR9foQuREmZ8cspj+GfhqQdgxEpmycJypFilj9UpXY+?=
 =?us-ascii?Q?b6d6UL5ZameRdK9Pr8FT0GVDBucoGeMR4SvEBG5M34Amd3rvLRTi2t5nvhlk?=
 =?us-ascii?Q?9yifNDaXK/sd3+R/68tVuHocmBgNwldI3BX06RkLBs8la/HHq/FB4U5gLdpt?=
 =?us-ascii?Q?cIDKLPm16OK32EVhsqX0reJibU2fvZ7j67hc/+edws3KC6Gugu8Pj773aVlP?=
 =?us-ascii?Q?SGhjzM8GSvyuLSzb9BFhSDsn7gZPXfbVXh80ovDpGSuIopevrFSgrpWyg1gK?=
 =?us-ascii?Q?+bVxf7TGidKpPM0mNrV4w+Bbe7hXqf5e8ceIVT9XFUcTBqOJD4ZTQAG0MdZJ?=
 =?us-ascii?Q?InDSR192CdQNi5EwkUnd4sXP8ovzRAuOt58c1ntrhd3I3rdIdVOUNDN8ezJV?=
 =?us-ascii?Q?VZWDUnHh8TVqt+nJoCsTaqModQBfEb4xTXmvNIOHFsX0jZqhqF3AlFFuh+ji?=
 =?us-ascii?Q?SzvIiOXhvqmMpdmOi1Q2vqKXMvfdctcNKXmCBPspYKuAeAmzySy5dSzcRpkb?=
 =?us-ascii?Q?krY/VmJWNUuNc3cDBcFhs84ktQO9CRxFH1ib0KgelD9s13KyBYf/DOjlD4wo?=
 =?us-ascii?Q?l0jksNXuB74c8cgrE9q9qcz6/Cx+ySxoI1d/sbdE5gt6QpOrxSbkBvhd3EG2?=
 =?us-ascii?Q?MU/0WZKkBBjYd/g7mpf5s8+P4CQfLJCnQkMJbflYMGsVojV6TUnAJTA2mp7g?=
 =?us-ascii?Q?Zrj7JlTWKVt8hlGsOlVSWOwmtJjmOwtjt6m+DISGV2QND8K2Ue9bw3IgAgFl?=
 =?us-ascii?Q?YHqGBV2mP6a0ic29Sg/wlLKY14dx7s++93aGpuBvCwCf2DxXB2IYmQ9WNlPb?=
 =?us-ascii?Q?iEUpOAH/X/9xZY7eF1iUV4AO9Q125PQI+n1vvN8QGKHLnHhd9PZUGrXErBCB?=
 =?us-ascii?Q?E2a57oXs122uq3smQ3xlQIeGbMBk7QPfoFPH53lQYuDtJqtCmFLKGHlc5Oj3?=
 =?us-ascii?Q?voNMbEst54yBhsSmzO8P0zGjhGdCHAGioddT5BcP7B34JJ51tjE3zDuVmk+D?=
 =?us-ascii?Q?N3wkr1vyS1ghMfmbF6/KcLb3aB9k+sFBC+YdmFoSVhjSzXL0v1dozhYMY9sd?=
 =?us-ascii?Q?xg6g9+yGUpkPe1y1V0RiW81p4CzecvpSgy5NfWIufD2NGweNHKn6J1Z/Dgnu?=
 =?us-ascii?Q?U/hA9mVqPqYUoJ5TfFpQ4wwt0ikxXGytC3Gp7dTD1jSRZsjBVLXUwweZ03gk?=
 =?us-ascii?Q?dBd3fEPmk9hvQ1RLgxQ5jLw0Yeb7Wm1A77nG5cvx9yE4Xapx3Idc6PVxrG4D?=
 =?us-ascii?Q?iPzXbH+Bj6FVtjlAdFmXGknz3+VHQH2zgNr3XJXP2uBeET3OPAxYBWSEIE/W?=
 =?us-ascii?Q?G3X6vsK27GCa+Ni6w0+nwwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66c1aa9-6202-4415-7479-08dd77d3bd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 02:02:25.9140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0wDa0u5JMAzCGFf4FqwVzDANjx90A72bKzPg1JFeuEZYwHi1hyFv5dLvRM6Qhxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
> Sent: Wednesday, April 9, 2025 8:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: dan.carpenter@linaro.org; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning i=
n
> amdgpu_pci_slot_reset
>
> Fixes smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'
>
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 60269fba5745..eb0589a09a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev
> *pdev)
>               dev_info(adev->dev, "PCIe error recovery succeeded\n");
>       } else {
>               dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", =
r);
> -             if (tmp_adev) {
> +             if (hive) {
>                       list_for_each_entry(tmp_adev, &device_list, reset_l=
ist)
>                               amdgpu_device_unset_mp1_state(tmp_adev);
>                       amdgpu_device_unlock_reset_domain(adev->reset_domai=
n);
> --
> 2.34.1

