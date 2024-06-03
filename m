Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2D1C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 15:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3304C10E311;
	Mon,  3 Jun 2024 15:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OM+35V3L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBD310E311
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 15:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmVX4pYbijUagQ6qP2xDALImmUCDSdesVq7YxaEh1U6hTyiY9Zwi1HgNYhCPToh5k5TwSpailw1Ob/UluWti2MmYmJFM41M3p1DdOGJgUjY3h8IxMgjw09zNs6dU0eT3KUNC1y4fBIDDGRFQsf3hbkMInMptNrCAzOrs5AumGVKHcLv+s6MVXtUBdBpMLP5eUZ1NRDIowgpQDYlHhT3RGMsoXgp4vCFv47j/ICIC68JfaG8/7nWysbTxLXvAhLRVTXaZvZGJDsm+s/qMRVJgd2sRTYzZr6R1neku15esnK+LIy820pave1r47SasvrQ/wenigU8EZ7X0Ltn+P6HUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQqhxCvhN+FKigTuc951WPwerQsOGilvd4ZqzyG9fV8=;
 b=jXIuvn9SgmXf/LIoj4uGltxX6R2ibRH9nZ0vkwDrDElDu/bjlCno1Vej85POjAjJ0C/algjAEfsT1WtfGWplFGuUV0vOHsImGWmwnqtjtuOn6WrvLMxCAdmLQOi/flbAgnDP6rhGMUpqlUV32R2RthWlaAgjxBVICiM5Zgjfxbx1bdD7QJDWEhKMW4vh4zftevjyJnRCC795CzSSTItPmjPf93aIbnFVkTG1fEyVhBip64X+LUWUZp2qRIj/glOv6R5U4xyfJhQ6I9ePohMtOsYylFjV9eUnW6TjFtDuc5JApHZ9SxUusy8scItIpnNKs2DLmh5qRnVJC8+a5iupnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQqhxCvhN+FKigTuc951WPwerQsOGilvd4ZqzyG9fV8=;
 b=OM+35V3LQUQGk0c5DQ6A0Bx/SGg0kAVeb6PBM2grQW86Oopp6rMjKDGVOLhFW5vbtG/4Bz14SnozK4LXyPH/Ju4lus5xwCoyidUvOUldZFK/PyJ75rFnX+7vYy4OXdwK8BXbdwYNYtPcp/CWrQGGWqVDjrX+Gb7aER1bTi9Ickw=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 15:04:10 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:04:10 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set PTE_IS_PTE bit for gfx12
Thread-Topic: [PATCH] drm/amdgpu: Set PTE_IS_PTE bit for gfx12
Thread-Index: AQHatcYElqQVk5Qa002YZoBy9YUrhbG2IlZg
Date: Mon, 3 Jun 2024 15:04:10 +0000
Message-ID: <SA1PR12MB5659B1C307D2F0356376CFD1E9FF2@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240603145305.197978-1-Frank.Min@amd.com>
In-Reply-To: <20240603145305.197978-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a17eaa17-7e71-40e7-9ec5-3cfdbb6691d5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T15:01:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: f7d1590a-4157-4c5e-6f5b-08dc83de6c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?JkxPBAUjmsm08maecAAujYu3U1yqUtQ/BC59c+KvzNA6PcHSkWjf/RBCaNZg?=
 =?us-ascii?Q?NjYPXJdj2+GwfmvTQHfbhRfdmQqVzznbpE+LjURNC5pFMNrj0ky4Rg7dRB70?=
 =?us-ascii?Q?LqxUt+utepMdcgF0Ad5vrxTE+ew2TTumQpIMfZNR68Dxq9VHD2Wn2HtG7S6W?=
 =?us-ascii?Q?CcxdTQr2NM796yofYXKX37U893EPiZOs4+MFNjRPsrVP4B4kru3U4KpJVJpx?=
 =?us-ascii?Q?uP5/yNERzgOmT+UAFfz+Y1ApPCjwbAHNkf4BsnfevnzwSMJbmJU4rSKy4Yyn?=
 =?us-ascii?Q?c5VMozriLw8y4tdQG8yGHKP+/131rypIfqzMloiWFHFrdqKaLoBqX9P+k3KF?=
 =?us-ascii?Q?MFDlTuPzGFL5Q7k2hhMyItXXB8j76kjOM+kLxzZe7BS8nVBnzNILvJgVVn9x?=
 =?us-ascii?Q?dwGvzkSa8TKjVbriOTsHe/+gcUfyYt3F0/wo+y522SVO6nCtJbCr7R7Vs0Kk?=
 =?us-ascii?Q?09AeWzoLO6+T9/MaA6FAXe+dVs1UNS4oHnSGFBSY1jaHmeP4F4am8lNvHX9G?=
 =?us-ascii?Q?8TCYNXr2YwCvWRvD7sxfwhv9SvVygF+ABzV5XroScl2jmMLTGVpa9eTvJfzH?=
 =?us-ascii?Q?owO5hVLFbBhg3TAci7q7+DvpBz9y1JP5BFapKn8HMYYYy/oj+6W8rg7ID6Pm?=
 =?us-ascii?Q?6mxvSekaWRoiO4cjW5lvXuiEnFYfs/JzwaoONRSw/RDwXIsjiI1a4jw9payA?=
 =?us-ascii?Q?go6h3f3EuM+jcoaSAa3UqQDC/3Ue63QSbRUpZfos8b/LpeBusFBwZ1nQ0ERq?=
 =?us-ascii?Q?FonY8FYmh6Sycm4TAkB9lc8295CjCFI7HD9LskY+IyjOeDZR6HeEi3D6cRgi?=
 =?us-ascii?Q?vvso42rseFo2WByVaDGnScaO11eAWOQ7200Ccf9OBXtBVt5Zjjk/BWPG+8G+?=
 =?us-ascii?Q?6d5HOzL0X9LBR+F7U2J4O2G3QCGFSgcwBgSRuZHwF6rhOg983GmfhirUjVNZ?=
 =?us-ascii?Q?NlSD2lAPOnnKDevwRasJF8p2KzNhFjteG5/URnBAaNOeStamYLqnT9pTAhMG?=
 =?us-ascii?Q?czbJK092BENaKgShMwA6l6XjwY5AoT1N9LUshM4V6aD5X9B2SPlSaHb5NG75?=
 =?us-ascii?Q?zbDWSJULnDGxKbFC79rrhKpNmJ8PVo8MsCu/jBJkQXKWHNBURUbUeKRQnh7X?=
 =?us-ascii?Q?a4AYaGGJCD4ZCoM8C9Kvhyr0aBzR4vyAQ1J3Svjns3eN0JZ4Jy/4RDd6Easd?=
 =?us-ascii?Q?L0N479cdRRBj0S45a9AKW07PvsFiUaRomSTwE/si6r3RtucrIOA7WaTAj8Ft?=
 =?us-ascii?Q?9YdyZpwdQ9Bl+WJeg3eEYudquyPnD/BLooGnzk2FnXtYuxpN4HoaaUyVJoLF?=
 =?us-ascii?Q?TGDaSpxN4oTEwn5ihTfvUe0Kp7povVzLi2qFiil7LMbouw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pNA0uLnKz3cZ92TuSGYdar6vwqLv40/6LpW9xBxHAKzEIzuLlUdE3/1K3iC4?=
 =?us-ascii?Q?4QFHhjsS8OFBgKKHLr8SmZT5uTCFTxxu7ZuPX8PGhOrICd2dJ+uL5bdjFRlL?=
 =?us-ascii?Q?4HyWHDC73IreyGrbBiYKJpl24Cxu9ru2vjXOD0BOjiu5zFh16so86/8vaGbT?=
 =?us-ascii?Q?Y6PDGz+wenJjU2C0R2l66lGAwzA9qsV93viH86+4NFDupY07MGK+K0phoMQp?=
 =?us-ascii?Q?+s7PWubGIbh38GuoOr0+Rut4b22wraOYyMH4ICDk/Jas1AJ86a3ki22dhylj?=
 =?us-ascii?Q?LvPwF2kaV18wpOsR45+NGVD7NoiapY+KvIL9ZN4sGkBSONPimLu/bPw+shaG?=
 =?us-ascii?Q?VoX6bQGxbSFeKbhi/CY+PrcabmD61Vko4B6dJyxKFk/UVRXCGCreARHiNaoi?=
 =?us-ascii?Q?t0h2aM23VkGais/Bo2xD2etTNb9sfRbmB3MFC01oWJ8NBdGUTkhicK3nMBsF?=
 =?us-ascii?Q?RlOvNOYzew69mB9KQBwTMQyqzdQXUyKRORSutDBOrmcUC89mD/N0CSaK7lhK?=
 =?us-ascii?Q?yfw2d+pgEOa6fwpq1PITv+uvS5na9FTWzbAwbZYeqANnMw84m1m2x3lwGQz4?=
 =?us-ascii?Q?F6vAngp3UGDqnipLZgbGtspjbF0sp6GFeHg76dJXsH0+9RjoG30PXW9bpha9?=
 =?us-ascii?Q?eQVWgvFs7Ji/rq7BVVimYAHn3fXsmCRG3nEC2gNeJrYFYAsEjyqbRYKo1NCF?=
 =?us-ascii?Q?DJ75hMinImYcVUKj26yb9dUK0But7Lfu8Ch1e6KldqkjZfRNghNSIA40vMVx?=
 =?us-ascii?Q?TftrPl9aMzHLfi0IknY/+W6LJ/qaFWLhy+uHpQn/kzQkZ4nFX6uXwPmveAsp?=
 =?us-ascii?Q?ULur1iYoKCIfPVkfz9TQJ2n6nE/ntWUUzMQm3iWqJWbslhsDG4X3eq2ycAT8?=
 =?us-ascii?Q?REeCgDS7MHY6o4aKZge9oGKuoJQp8XY+YR9wzyMKWrNaCjWJ7VEZ08Ddqp4F?=
 =?us-ascii?Q?RLcdyg7MeyMOtU2GqlVWnIsvMv1VnAaeMWanKK8GsI1Dc56UrCqjLJS3AMqh?=
 =?us-ascii?Q?bpSby4uo2ytHga1BO/Vz0X7ZMyUfcGbsiGR4yy0k+oSp4EUTaMn73NNbooxR?=
 =?us-ascii?Q?/XdTHVez9YAkLGyRv7RJ1Uym/2wq/vU0StP0ufPdau66FH11m7sIuXKDOMfP?=
 =?us-ascii?Q?R2aWRZk26RikYC/tjzrhueIlPPe0OSh8Ju92LR4eP3dDWOH1gEZV7GKAS86Z?=
 =?us-ascii?Q?D+0jeEy42ZNljf6W9aoXmvzfxseufhdzfo6dxzhoQeBnyRGqiPGCqYlFfSQW?=
 =?us-ascii?Q?13ZDHDoJ/Ec5FBjrTLI7LVTLBlMoC9cKwWIEZUeT4cNCev++EUg5uMhCao8W?=
 =?us-ascii?Q?033csTRXq3FgloADbzGSlwntQQp65u6uceF/scZNy5CT7abIf1Quz9QdIqnx?=
 =?us-ascii?Q?6X21Xi9eRNeo6oq778E+E9ug46oenShd0jmtOH9nzaMWGUL5NuX3v7yJTGp2?=
 =?us-ascii?Q?zvgWMmsWiubVRv/N0yaSyuJ1Z7+gQC44H0c28e3ryYyckRsV33Mr9NoDKGLp?=
 =?us-ascii?Q?+pv59k3zGexbkiFhYNyGwc47H/ct/c7II6ukoI6auDIkIuvI78r/ffFCBmBz?=
 =?us-ascii?Q?uq4ZzGTxgxyfnogKaBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d1590a-4157-4c5e-6f5b-08dc83de6c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 15:04:10.0229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38QEaHxinCLuoPLayNBCcXw4gedD8LI8v4JPcDhSVu4OFzf7+3uPrh5tqH8G7c5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
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

From: Frank Min <Frank.Min@amd.com>

Set PTE_IS_PTE bit while PRT is enabled on gfx12.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 7d99fcc58baf..e09be1a6c7d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -512,6 +512,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *=
adev,
                *flags |=3D AMDGPU_PTE_PRT_GFX12;
                *flags |=3D AMDGPU_PTE_SNOOPED;
                *flags |=3D AMDGPU_PTE_SYSTEM;
+               *flags |=3D AMDGPU_PTE_IS_PTE;
                *flags &=3D ~AMDGPU_PTE_VALID;
        }

--
2.34.1

