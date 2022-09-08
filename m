Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9B5C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E430910EB11;
	Thu,  8 Sep 2022 14:08:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F78E10EB13
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W38nwekK0ov1+rz5EVuuDhidBfArvgl+xetGmnKHYOpAAdwMX8hhpI4Rv45tVROFacK5oVTSdchUwSpUcjEYAlOH2T5ifDCyHxC5UkxzcN5pDPCHR9KDTgziPyXpl4myHqgDZLhlRDRlAhETydObRHp9Jh6Ea3Q2OYIEEmvCttAOufYTNbc3GHEvtK39UVXPNxjYuXH8qma3uFpHLpKppvNLbQywRKtBgasPQyDlHx+miLreU86yaTx7VxV//zi63sE+gFdIVbGWnQzSj+CvuHjnj0LKd/DQtCcfaXxuaxWeDRK6tRjtoV0uhMGDcbuHkPdMExDnci8q4zEDC/pbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlkMO5t+okWJe490XoyNdp2pc7W7ZNgI5wY9MOa+eGA=;
 b=IQMpjztQXnJLkAqhIBlaZmJnYQdrfZP5WMB1jGro5drDAAGe/YXVQGN8JX0I5kKTbqONnQdsorScvNj2K0LbKVUrSLJOuUV+/OaGzOaRXOEBg5yoViEbC3aaKHpA2QQw1ZOmriWXn1owIwS3fPqlMaKshcam5DUDgCF85v3Op5lPe1AXa6KFWq2BY8d9gonoyyEQhlz6EmE/PK7T/x8YbC6+7/M1A7zbAEHOhbELtLML6BHKSKDFNSil2x9THxWSPEFyUyhlNpOJZSkceOQdWDOARLCd6YOHU5r2wjVUxExqaRREimTVC3PZPA58yAEhvJPMxz7e6HOL1syiavE3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlkMO5t+okWJe490XoyNdp2pc7W7ZNgI5wY9MOa+eGA=;
 b=hmawNp4RbYwRh1hswHxeWmr+xbnDAxYrnCkmVnCzqoyk44UO6o7HRaQQ80cTYcKsQpkbL4BQyBlz6Gdk+Q7FfyHedDjYX1C2mZRHC2RXrJygQGS5fE913EkPa5pB/FbyjIsvgDghHww9Ja6ynGHHePBkPTZORkLO3qyoQmdho/8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 14:08:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 14:08:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "tseewald@gmail.com" <tseewald@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Thread-Topic: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Thread-Index: AQHYuGDitDzkYUzebEScN++Q123RTa2/6KoAgBW+zyA=
Date: Thu, 8 Sep 2022 14:08:36 +0000
Message-ID: <BL1PR12MB5144986E6FBDC106E49B2F8EF7409@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
 <20220825180134.GA2857782@bhelgaas>
In-Reply-To: <20220825180134.GA2857782@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tseewald@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-08T14:08:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=70d8757e-f65a-4bc6-aeae-1a9404761aa9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-08T14:08:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ee6fc43d-6e53-4e15-b587-2d09e527d6d0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH0PR12MB5153:EE_
x-ms-office365-filtering-correlation-id: 519b0086-fce9-4940-9dec-08da91a39fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGPrVfGJTXZeP9JPSXmi1vPW7eaLoeu+cVxIB5QM9fOq0uXuFgHAsW3k8G0IBVSHF+fjPu/uk3xq79oj3WpwEq5Go7wkJV9fzWXJvAO99WQhLlpbz/cuk30jGMNp6VwGh7dkZkXkeupMLJWQHACEcbjNUZqZpnhXFIqhZ9ntHi477tDQ6QhAlqzbkz1P4LwiZLXmcC8m3VK3irIz88SJAc/Kqk51AEBT5VwRCawBV7O5X2MbL4F1zHwgXvV2RXmsMX+3yetCz8zbEDuq8MTEwzdIlmJ5BOzwlc8u38vGkNdGuXr4LvYvdgx6bGAx4aB/vXRwXTP54toLBmM1LBW8ZLazVNchjhAfjgcyLST9XNEzYWYloyLuf8SArdYRSCj1LEuPcTAImVY045Un97ucCSmroCmDLgqhQd4VuIOqYiBEr9mWFJLdmPuTYxYXTvhMvK8ABCJoaJ9f2SiLLmOFZfhaAPorInU8JRJhFqksIYcqpXj/B/1bSW5FvfzVFxEw9Taoe16WHLt+jW1FZCFWWag6pBtruweCBrnDuHCY7ogYNPY648eRE7BYVOUyWveHBGHT9Weg7mG0GXGLnEsSY4ltHnIx2U164hv5KcLcx5bA97FEy0niq9uOVT4CvDe2qhzm2K4pug9WIeP4/1GYnNbPC0TOKxOeg3tgsMNvCLwFpEKgtQqJQ0TcUwkAvX89WjtBGqlZzZCELtLW5fwsg9Fvcbhe32B+1DR9ctj+RHmON+/Whpb1d0Tg/3AMhQZt2jH5kVzGMM0/FG+kpEsqTJJqYe5CuDFDb3iJnSUSwUA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(52536014)(33656002)(53546011)(26005)(9686003)(5660300002)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(55016003)(8936002)(2906002)(38100700002)(4326008)(6506007)(316002)(110136005)(54906003)(7696005)(8676002)(83380400001)(45080400002)(86362001)(186003)(122000001)(38070700005)(966005)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KYr+TK37Hwv14nCRSIIMuhL1qWVeKssNVR8tM2t3ahTYLhLCXR+dH/2UfmRw?=
 =?us-ascii?Q?I//kc74Ar4l466K0WXqDupKtGkEabdsPnYSBEGzdo6iWl7yPXSZm5e85Yi15?=
 =?us-ascii?Q?7Q9dYQm6sbWhVH7GfFu7WkjsLcsN9xtQUZNQRSCsoUrS/Jgc8bF+gkJBbXjT?=
 =?us-ascii?Q?d30tNT+3rtkUY2kr60JzM/nRhQ6SFh3e2qk/MRgSNYLsscu7yMDzy5wo5dT4?=
 =?us-ascii?Q?FI62hChK5/ur8q5xr0ja/ayg1htIhDh+I0zyJsglCiq3XExZ0geCk7JDGJ9P?=
 =?us-ascii?Q?AIFQKoVM7cjKh7rylC7NIdg5S+ZiS+wc6zm/6wxfzaAzLVQ05hL5OLOZaqNt?=
 =?us-ascii?Q?vwEIHdc1AtxQa7lXGMr3jXgGLKRpmzyTEte9rxb5Ht9kruuWCV2tqjMNlolc?=
 =?us-ascii?Q?GIWk4MZJZSbnWA+IgqUKZZoXAQuajoPYQa0nSh+6c1Q4qzUrTGzlUJCJXjnV?=
 =?us-ascii?Q?7my5R4fIoerxDhlSbOLVs9Ym9y8mW4JGuOSn3Stv7PZs2oJGwxZlHtt25NvK?=
 =?us-ascii?Q?e+NQKRg/9291EsIHmk9y3la3vYyOMEzUOejvIwn5N0wEqHNxxIVarRAor7TB?=
 =?us-ascii?Q?S1/1EEMbiKyx7MISLzelairjT4mW+vyOGlhzYZFJn5cP+kFiu2Oe/2Ze0/OW?=
 =?us-ascii?Q?elZrKFsGA4jlLo2DhVaC6iA5ngEDBmfVBXvT8c9/Z081/K9m5cnTSUggVd0G?=
 =?us-ascii?Q?3N74vauXVqaDAn6zgp5ioAc8xKcPqrF6OJ4noK5k0fKBNgkwaEdWBRpSmlIS?=
 =?us-ascii?Q?IAPAUBp4Y9j6v3aEvLDntadIpvH4uQvwFf/XleYmsScShKFGMU5VfEREPTU4?=
 =?us-ascii?Q?9Lak717RzvBuUe8LtGXdSIhM3OJOITzWzwSc6Gqyi8ejYMhWFaLUP+YvTxca?=
 =?us-ascii?Q?NlunNrBMrzuq1ZVpU7Tk7FR1Hi/OOx0InEDGQaunW7oMNrKYmECPfq/eNSHW?=
 =?us-ascii?Q?suDUktY2aK2vdwlgP+4MgQtKovA+5YeyMjFMhzT6acwYWJ84dcrfCwBESOzM?=
 =?us-ascii?Q?IrgQRs7LS5yjMtQ2s8QnoOxC7BPfih2/Q3z9jWqDwXjGb9SVgzLbIY1iWLF0?=
 =?us-ascii?Q?p+YnhsSxfUokoghvjURwg27iwKDApCMKJ8tf6PzptO4++y7UmPwcmG8yt9UH?=
 =?us-ascii?Q?tg7gkdQSIixSwE/5sv+xgjwivuvrcZf9EJRsFcBRdiEJE0Rin/vTnXDgUss4?=
 =?us-ascii?Q?InCeZKHYUUswyLd/XkpxzmMrTuhfY/IPJNDgkaFQ+Y8xxkBjzXWfLdSroFFR?=
 =?us-ascii?Q?HOF/Y+V/08Cm1AMIhBLlcs3n2AmzKAXS9+affGo8ZyJFrf8eKz4OoF3MUuMX?=
 =?us-ascii?Q?pyarHTFxHcuYWO5tOQPw+T6K/AHnIcyDVtoqe9VchCBEdwpKCzP3YrMqRunR?=
 =?us-ascii?Q?0oxhjsDcKaI78ykUNYV9PIUdX7qViyMDOCfaGCMVNVJD6QQX9l8+HY9j66Vi?=
 =?us-ascii?Q?XD2XwZig8+qV9081SwM9WJSnTX0FT68XXNvsOc90FcD/w7dXOy1Dw/wfzMvu?=
 =?us-ascii?Q?8U1KJM3ziduwHr7H/65OIcjEqsSZg1B8vETacu2+YKOFtTWNa7IC1GOaNLbh?=
 =?us-ascii?Q?bw7+4Aa4L4K4qPoD5Mw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519b0086-fce9-4940-9dec-08da91a39fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 14:08:36.9784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quy04QWK9Jm/B82f034fO3VKM8CXTazLGENQy/TOsJNklP4Q9hvkAoMCDBSV6hnItgOmG57DS7x9h5yuMte8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "sr@denx.de" <sr@denx.de>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Bjorn Helgaas
> Sent: Thursday, August 25, 2022 2:02 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org;
> tseewald@gmail.com; Deucher, Alexander
> <Alexander.Deucher@amd.com>; sr@denx.de; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during
> init
>=20
> [+cc Greg, no action needed yet, just FYI that stable will want these]
>=20
> On Thu, Aug 25, 2022 at 02:28:19PM +0530, Lijo Lazar wrote:
> > HDP flush is used early in the init sequence as part of memory
> > controller block initialization. Hence remapping of HDP registers
> > needed for flush needs to happen earlier.
> >
> > This also fixes the AER error reported as Unsupported Request during
> > driver load.
>=20
> I would say something like:
>=20
>   This prevents writes to unimplemented space, which would cause
>   Unsupported Request errors.  Prior to 8795e182b02d ("PCI/portdrv:
>   Don't disable AER reporting in get_port_device_capability()"), these
>   errors occurred but were ignored.
>=20
> The write is the error; AER is just the reporting mechanism.
>=20
> > Link:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=3D05%7C01%7Cal
> exan
> >
> der.deucher%40amd.com%7C3306aa3e6a834f2d394808da86c3dfb1%7C3dd8
> 961fe48
> >
> 84e608e11a82d994e183d%7C0%7C0%7C637970473081942953%7CUnknown%
> 7CTWFpbGZ
> >
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3
> >
> D%7C3000%7C%7C%7C&amp;sdata=3DDFqggIRt4sKNjJB5bY14yi5oJ8I4szzndQD
> blr6Vcr
> > c%3D&amp;reserved=3D0
>=20
> We need a cc: stable because 8795e182b02d ("PCI/portdrv: Don't disable AE=
R
> reporting in get_port_device_capability()") has already been backported t=
o
> at lealst these stable kernels:
>=20
>   5.10.137 5.15.61 5.18.18 5.19.2
>=20
> and these fixes need to go there as well.  So add something like this:
>=20
>   Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in
> get_port_device_capability()")
>   cc: stable@vger.kernel.org
>=20
> It's not that there was something wrong with 8795e182b02d and these
> patches fix it; it's just that 8795e182b02d *exposed* an amdgpu problem
> that was there all along.  But we need some way to connect with it.

Will update the patch with these comments.  Also @tseewald@gmail.com can yo=
u please test this patch and confirm that it fixes things for you as well?

Alex

>=20
> > Reported-by: Tom Seewald <tseewald@gmail.com>
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
