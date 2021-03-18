Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ED4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE5E64EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE5E64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FD66E855;
	Thu, 18 Mar 2021 16:32:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B12489950
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 16:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilWhyRdnt3PftITMg/zLmJpGgG1ol7dAS7M2gJpvInzN3tFBIelzz3QwdHz1/QVi7bs+BUjW6UvO/8tAlypPR1w+GevAMBvOktQiGCSyf40vmXFs3F+fCSSmryYq9OTaHNVyLp/pyIvxWEQuIVuSyO0BQ3OQ6hbcnRt+3/dgahGPvMe4SDtXfL9BYf9MscI5LPPoHwrzdJ0zjCxB/0dzNt3kdCcNMTiY08OrQ0jggfvwa4dT6u8yuCIAQTusR8wRF4DP596JnfYdOt9GdAP0qil70C8SEGBmeseL2E8b0A+4hqtVYC594JtMfFrG+h1841o8S/b+oEqBSSR/9mWBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOGpiV2d3FIWSTNhPBLexJZVN2/Mq6MaJhsYFRjo7+s=;
 b=NLma2TgrGUb5DpWppuq2MagGTJnLhNFcAR2G43dc84bcbKxPUiiig5ujtngJdPs527tTTdJAhihCasS1xWhyhFs36NXTVnSVn3LG7KtK4oJ1k5D8wozV72IdMwcFtNyGnlyQN8siCQmMybjls5T7OkNTfz3TvFVHMXvYJ/qVIGijJocb1gsG6H/gYj5S+l4AqeLrBCfrTV2qarOzqvnBYi4mrij17IAXsNcPVQJD4G7eIFfhv9Hg6IPiWXXtteL9VubUs3BeWc+93CTQdovK9eaUDcVi855hw9kxl2Zdef/qNy44d1U+nqcutsNinSby1h0oKePL4wng/nimjM7ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOGpiV2d3FIWSTNhPBLexJZVN2/Mq6MaJhsYFRjo7+s=;
 b=1ExW9Nl96QjVhxPbKYY8c/61mMcGCGxsCG/0iXKZCSBxkMuEfd30z9LEsiU35bu7yp1I7v6akoezpqRxWFp9f4VV+NSZXhGfUHRz2AYIaDmUMtV5yOuW8Kh97CsaYZd8txqReP5hlMUYt1ENsjpep7g3yrOJiN/a/Qg5LEljZTU=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3755.namprd12.prod.outlook.com (2603:10b6:5:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 18 Mar
 2021 16:32:19 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 16:32:19 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
Thread-Topic: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
Thread-Index: AQHXHBCYGQ4g0pQZ/UKqzjYb2ngpmaqJ8EqQ
Date: Thu, 18 Mar 2021 16:32:18 +0000
Message-ID: <DM6PR12MB33245CF78AA4127C302A081E85699@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210318160530.260-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210318160530.260-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-18T16:32:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fa7a4de0-2407-499d-a991-edd45828ca15;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:bdda:d651:986b:e5da]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25b4eb56-063e-458d-15a8-08d8ea2b6616
x-ms-traffictypediagnostic: DM6PR12MB3755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3755890D50E318AE40B6E15C85699@DM6PR12MB3755.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VsYLqILyjpDNmSuKA/hbq5aBxq+wh4POT4KJPEQxPaL9kPwX7vRDYSH2uWuqhGdWILR2UySiEGkMswKlOoQEVWJu8hPRJ66x/eoJWY+jn6uJ4EdzUPmZQwd7ojD73f6fPtIsXJosPNG7dk2EmRzj8xpuLNX+E9R3ER2/SDmAaes4wx/xpq3LUOCJTJC+rQ/DigM2OeLx6blMHeC8wgLDOIuMhjFvW9TsWw7LugcDHd1TFIBqvBAfdwj7uzgoUqFEyY7xgyPkgJHNweUDtIyFLml0jp6Oz5IJjijlkq0RBQUTYWqJMMdN61bUY83pWoC9sZw6c28XuftJsm2ElWh4VWucohw+KbJT7Jrvm4FuXXdYxccfil7CVjccWxarCOf9Y3l2QWdk+9xmvXdJYT/fycgWWpHvERbzQUgQk7yNFUsEVN1/5rq4DkrdRKE5/ODefiPsYybmFFsplcFIG75TziwM2TLLh6daZVQA7m/ezISzDarvzzqoKdjsPOctvn9yBgw7SI2cb7i+44KHkfsxUV0CwAylC5VskYpSobBOotUpe+t8fZ8N5wR3/qVkKgxXTd9wYbybkBJ50TO0dQRA2ASKbVuIHrW3VjcT6qDwVpwCBGLBa45wvJXWMcDBHE1k8tmVllPqvCwGViN+urr4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(478600001)(86362001)(45080400002)(66946007)(966005)(7696005)(53546011)(38100700001)(8936002)(2906002)(64756008)(66446008)(6506007)(66556008)(66476007)(83380400001)(55016002)(33656002)(110136005)(52536014)(8676002)(5660300002)(71200400001)(186003)(316002)(9686003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NxZou6JKaDS00d81e16ycwtEaNmibKGBvuFKFdPshIWu6nEBUQhv4N3KW/Pc?=
 =?us-ascii?Q?AOPjfI7LmP2PpOX/jMrGV7MsEuEYiCtKm1kUld59A5+YAEkVMO9tOnwaf+Mw?=
 =?us-ascii?Q?EN+/kf51qFigNCxo+qTFNF9WEmNEKoGdsDNz3FX8QhHKTYCGUi7+e7wthxS9?=
 =?us-ascii?Q?NXE9VModmnsrweDark3ouRvdvIYIb7dHp3d3UH+g9wz35yHSTcW26Qgp0iBY?=
 =?us-ascii?Q?jxL0OAhz10oevdmhf0UEegzYvf5obZIBlesBL4PYMz1VF59MxCKAdbNPS7Hc?=
 =?us-ascii?Q?yaayy7fpdeXd+FBArbzlER9xQNKGjSYhz0clIwHAOlL9pS0ZUNFRTQbfpkOb?=
 =?us-ascii?Q?qBKpJ3Vszlt2qQ002AC1fGqVjeIjWgYCIaV3T0rC61jpmw/rx9EGnrstQJH0?=
 =?us-ascii?Q?uF+WKXUzdsx219G+Z5S771iyBRH0yo0OiR27FMntmQPiKVxc4rMpulWM+0CC?=
 =?us-ascii?Q?ly2yMBzhSfRNBOoapxQ6IWYpwoX0YV/JCB1BKDZox9m5YMIOySKq/hm0KfYH?=
 =?us-ascii?Q?NhmSuMhKUQmMIPcVXjpjdD9z7ic46OBDp8XF0QRHiCVF0kB77OOUr0xD5mSZ?=
 =?us-ascii?Q?MisqGVZP6kc5oLLQ1LZ2eiPfrFD6xGUAjPcy/wbnZkiqhhnVQqUAHXs13lHn?=
 =?us-ascii?Q?q0g6xwQ+uH98xDuVqNo0UbzFheriWor0nZTWoXEd+kwAwJMbQL+rXoFh9Ts5?=
 =?us-ascii?Q?YqcUxfBxwz5/bKW6H94Wtd0L0xFXKG4MI1NxgRNTbuWB6iuZ7L/J5P7kV15s?=
 =?us-ascii?Q?rFsaRVN6FWfbItiHNToOs2TZQt9e1tErdkl4Ydi+SMkrQ5cWLz5Pn7nXi1I/?=
 =?us-ascii?Q?Pn1qBRh0ZPSwwxDPOWYf/el0WD7FV2DK5RgZVOTXTCt8J1fGOXh53DDfcG5I?=
 =?us-ascii?Q?ZWElno5cT+WCisFwSsk9h+q0d13t8Wp3/A5mrL1naFGRlCM3o0vsazLme8ah?=
 =?us-ascii?Q?UXlMrRK9LVHf7PXA6FQMjcc0FO+ySJ5mztkOyIXLGJ7PeA6yK+s4MXUPxl7T?=
 =?us-ascii?Q?EjaW4sbkmcAeEKCws6VJJkLOqPvas25pbMEn6Z2HzZxJMoap1Mm+NwFDAImO?=
 =?us-ascii?Q?kW07wie9k8AwA1pVVOAhDrkp5zlB1jE4NOkhMpp2vxX/q2Q3/iz1ou0B8zpX?=
 =?us-ascii?Q?I01Z9DlRtljzfj3FEQShXq+AtUmotyFVyTW3oYIm7ORY0NQubIJsVqZ9XH7a?=
 =?us-ascii?Q?OohRCQNYd9843piXYnXHCo0A3WzkHiN4LXQB8ASsYEr2fLgV2pVu6qfnagrb?=
 =?us-ascii?Q?7VEnRrY8AV1G70hotR5wzCGDK1p1bWLeuGe76HaYljDjt+JJVOxBv/SlSRHW?=
 =?us-ascii?Q?L5fd4qgzrNhtzt6jeFqN2CtY8epW0D9AGxunYc/YUT/9oaMccYDVgV1LTD3b?=
 =?us-ascii?Q?jLlz4vYNHGpAxu8JA0qYq6xDdXOB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b4eb56-063e-458d-15a8-08d8ea2b6616
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 16:32:18.8262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTCUKNAf/rGYdEv1kjY23jNz0TN8GO49cVSlQK5Z/JgHXFKokJ5JaiQzNCbPJEjllODSqBTwoZUvSvYqhR9Pug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3755
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Thursday, March 18, 2021 12:06 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
> 
> The HW is not in production yet. Driver support is still in development.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2e7b5d922f31..a3e3760e8d62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1179,9 +1179,9 @@ static const struct pci_device_id pciidlist[] = {
>  	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
> 
>  	/* Aldebaran */
> -	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> -	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> -	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> +	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> +	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> +	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> 
>  	{0, 0, 0}
>  };
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Ca58b14d47cbf4b23a11008d8ea27
> b9ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637516803643712583%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=yPjcheikiBkipF6jux1pKQv2XpNDXxEEDxu022uOB40%3D
> &amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
