Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB8DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994F464F04
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F464F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8586E19C;
	Thu,  4 Mar 2021 07:37:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC11C6E19C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+DlHvXec7ry+ewlz66ZiJ6/SEvh2jz+l9pM4F+q8Dp4DArv6s0jfKfl4WT2suh+wK4fuP6F/h2QTYRVshK1QwTAP3unLGz5+2xaa6pvbGKkO1N+RVu/1KJacfUzrGZ4cAD1rm2QfdVqG5ql8PgY7aDhS+ukAgbF5ujLOKuEk1hdHRyWkRGZMFw7HbYgU7Wv+UDCZDlZ6DgM9AEiy2EySDfVeh4Wc4ZmhtEeqeeNEvsrwD6YfvaxAoWOzhnOlg1S3rl2NwOQB04kfzcOFqoc8nY5of2IibUoSQENWKapCcwPFRGL2rdZ5oqH2WJV1ZpNffmB46/bdmmFfumTJJ4qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY0FGcsqQICZs9gvSPDihhpbXEiw9D+HdQMRp/O9mAg=;
 b=NP32CQtDCiqkj9TsyIlUEevfbN/ReEfGQhnQUGYp9TIuemElbo0TwI97jwlvRWxwb5bgCC8+BOzAgLnrHIYkCHLzZ9orA6Jkwmiisdibxbq53njppfAnOTL3rmpTLJPT0pVemNBZIiw2AR3PioThjeSMhy1qXSi5RY1n1repob/vIIVLSDk2lkztoo1KvJ5EN8PfCkvNto/ntKgjKvrR5WrguvZt+22KCYYN0g8IFi894/AQerUpefkbat9rvkzjJVoWkU2NXWlzUQpeKw7ITcuY5ssdjTl29NSIE8lbeDwEyTyWe+zze4ojX4Tkfl2u/gO/sJccl2GBhtzAYpgcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY0FGcsqQICZs9gvSPDihhpbXEiw9D+HdQMRp/O9mAg=;
 b=rwIwKeArNUP8CBsM/AQ3D6+UtmKVgGS3Uwq9uF1ZZz3N779neg5Ia/pfphDTocU0MDeYhIJbilUfkwQuKFFxlQ5rMSuWqHlLq7i49HnXafdBgMk/PCz8gQrMmhVP7ydOBLCIxMTwHNQxw5XeTpPVwOr4iIIIGaea9YY0Yf6tFIg=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 07:37:51 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 07:37:51 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Topic: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Thread-Index: AQHXEKkHIp2YK3CbYU+PKWKu9qZc/apzM8GAgAA81gCAAAA2wA==
Date: Thu, 4 Mar 2021 07:37:51 +0000
Message-ID: <MN2PR12MB4549B081A7E302B799AD828C97979@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304034644.37610-1-Feifei.Xu@amd.com>
 <CADnq5_PaR5pwTHFoOO_2-wKjWPLX=+LS0z34ns3axA1ZP2RUFw@mail.gmail.com>
 <CY4PR12MB1287AB27465A9332D7838355F1979@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287AB27465A9332D7838355F1979@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T07:37:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=17cec9eb-19fd-4334-8c57-c409772459d3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.217.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21363f32-38cc-43c5-8410-08d8dee06a7e
x-ms-traffictypediagnostic: MN2PR12MB3997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB399787667C640E62E4D94A8197979@MN2PR12MB3997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5URZ8SU7OWOvHHzh7en/yDPlwqxXbgLaWMpCu6jYP7DxmW2vrVwgNwYFMgrsqLZW/3kUJj9HjZwRpjeKxXlMoR/jNYTnzoBbVEohlJHK3GH9SBTBbkXG//7qiI8anQAhg7argspeg2iK5GuwOSI2aEWpW789QTz6erm7yujLnxlxxTQ5LNYvyhrIkn1jXfoHssNHjdc+qux293GXYcFahOiXL2iK3oM8Uqytm7OwdJRUdA3EytPCG7xkS2IYgMev3d2Uj1GGtXRqE4irL6pLK7gsCstYr7IUculTPBkhPOyhy+pBJk0SKyMTdvmXX7T5GXC7JHVd9Ssry2Ckn5bJXtrNoauPdGJlkWLeIULMyYyT7dwOoRvRWVf/a5gID8FRJS1i6nIkOVTcYlHXv+WNE4AjKQasvdfQtoRbuDU5DUxgug6jV1snr551NpiSXLGyagf0i3+9YzCIQTeNuHI7DGw9zt13dVpX8lq5feP4P+AN+FiW903VADQ1bE3h5cBabUrdXQdd4iogI8yacy4cloLkrBKwv5Zl27J5IAGtmN3mYwKbmVPt1N7Hrc75ycKA4VB9Q4WZ/NWjVgr0VECOnmH2XQY2YidooORnLL0GSTc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(6506007)(33656002)(53546011)(8676002)(71200400001)(186003)(4326008)(86362001)(52536014)(478600001)(966005)(45080400002)(8936002)(2906002)(7696005)(5660300002)(26005)(6636002)(9686003)(55016002)(55236004)(316002)(110136005)(66946007)(54906003)(76116006)(83380400001)(66476007)(66446008)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B0BXjS67fsHbWCN6RCvhzypM+IBYsu/6pcFgB6v6JLwNv4Y0n2tUOrblNWv/?=
 =?us-ascii?Q?yPMcMKD/ttUJfOIEwgj5AppJVRDQN3JT0wYv6H7u/4cmDtPD4zb6vD2+eTx8?=
 =?us-ascii?Q?HwDV+NAM6JRipwCg20enZv/Xo3A1vDGwGQ1t1TN76JHslZLnMn34bk1aQvKr?=
 =?us-ascii?Q?WK+EoA0Zv+HbXD9UC8lG3d5ijQddUjtefYxYIKyP6CZN8ynJeS6IO/Z2qKG0?=
 =?us-ascii?Q?5T+kpObhU53AfYFKQrVAtGMt5y03+v30q7/P0vc0s4OqPXtIHvjsLvxUOWG7?=
 =?us-ascii?Q?IvnCpys4T7jMTUCDKh63SyXmcBisJi7rlf1ryn/if2aWJ+2Cg81/oUa8r7zq?=
 =?us-ascii?Q?mpVvU7vnS7/O4sSVyx2iekhTPuyOOj3UwjdfCrzNNeidDQUlzI73yRX1guPP?=
 =?us-ascii?Q?sN7wRaxVSlBqzcpW0/CW04uJLT1IXNr/QWDBFpnGekk8Vfeen5PF8tcTfuk5?=
 =?us-ascii?Q?bQAm1UkEW1CLE7IbMi0uYmZJy2rCf8sbMYyfGur4EgR4j0uOYTzKZ1fV+W6y?=
 =?us-ascii?Q?fSrxOgkQ74TQXGshQjgckXntzkiWvpRdc3q+JqTSxRs35HZr42bI1K05ZK6F?=
 =?us-ascii?Q?Kw7VjzKvA0yypFcrhLStbCJe16SSQJ6VMmuRIVGv6BtBFYeCraG85KWA3DGu?=
 =?us-ascii?Q?ghy17wduaYftmfg51bGuvOvIRDyO4qDNvvMohvHvSyn35G/rjkLhS2YSUa9C?=
 =?us-ascii?Q?pCwNyLZbswNVNXcmpaBZDwq6rylUp9YFsMQcG3lDFpjNBmEFQpVWX0QJs7n8?=
 =?us-ascii?Q?W5+LhRMhptlGdcLOu58twt0zVhu9rnWVn8EjVTpvzHblT0dBofMTxjn/XUZu?=
 =?us-ascii?Q?ZDTM1HsJdKrKp4RUCjRqLvvzseeWPhTdCLhWWdYFTS1THwmSTxLVurLP2lN9?=
 =?us-ascii?Q?eA/zeeSijk6z4Kznp07JdjKER/LwM47tXbJx77qOsX9uu9ne0nK6kRIbAav3?=
 =?us-ascii?Q?MJGK2c9dd1zjPrvLTHwjdD1UCOmv2gVbGB+P+8w6f+tuj4jDuBg2uoORdhF6?=
 =?us-ascii?Q?d6/PtNOJEzoO3qNvmxPwj1NNTUc1xKxyehcV/Bf4yAucNQUOpLeiZ1MB1RdP?=
 =?us-ascii?Q?h4SkZaxzXGGhvIbZF/WsmxzpmQBUhrxNttT8/wRjlOpbaffqK8HjY/2MXFc4?=
 =?us-ascii?Q?3Y2c/SSr2nyQzd9oDk1AVzobXt2PHm9SiSH9zkb6lu0AG/Yn2hZfUYBdIqcF?=
 =?us-ascii?Q?poiMLNl4YOb/TRA2MgxPoHQPk21x32UmPrJ0TNcDqE7dyH5olmw4OSJFUpVO?=
 =?us-ascii?Q?FNKaxWCiCrPi5LLYxHQYtz3b6PjVD6sQty/1m1TMySnImPoM256Tfi7lkFue?=
 =?us-ascii?Q?0LEuB+LFz5CKSxIvhx92fy8T?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21363f32-38cc-43c5-8410-08d8dee06a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:37:51.2835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mh4M1SMY/yi3qRaWuJyX0Q1RmVPfaQps6a8ZEPzUeM3YSyWLjGpNJaK/JZnVZBHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

This function is doing nothing, is it necessary to maintain it? Not sure, if pcie gen support needs to be enabled specifically in driver.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Thursday, March 4, 2021 1:06 PM
To: Alex Deucher <alexdeucher@gmail.com>; Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: soc15 pcie gen4 support

[AMD Public Use]

How about module parameter check amdgpu_pcie_gen2 in soc15_pcie_gen4_enable? Is it necessary to modify it as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 4, 2021 11:58 AM
To: Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: soc15 pcie gen4 support

On Wed, Mar 3, 2021 at 10:46 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 28b991904eaa..437cdc56bdc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -569,7 +569,7 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
> +static void soc15_pcie_gen4_enable(struct amdgpu_device *adev)
>  {
>         if (pci_is_root_bus(adev->pdev->bus))
>                 return;
> @@ -581,7 +581,8 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
>                 return;
>
>         if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
> -                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
> +                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 |
> +                                       
> + CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)))
>                 return;
>
>         /* todo */
> @@ -1374,8 +1375,8 @@ static int soc15_common_hw_init(void *handle)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       /* enable pcie gen2/3 link */
> -       soc15_pcie_gen3_enable(adev);
> +       /* enable pcie gen2/3/4 link */
> +       soc15_pcie_gen4_enable(adev);
>         /* enable aspm */
>         soc15_program_aspm(adev);
>         /* setup nbio registers */
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cgu
> chun.chen%40amd.com%7Ca2af451ebb4b43bcc27b08d8dec1b4b5%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637504270832366776%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=jaNGe06yp8RXKQxMm%2F%2FdR%2F6DMC4h8viG3KUW3Sz2s7Y%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8f330aec736c4dfe8b3d08d8dee01c35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401425290833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9r5B6ckebE7FSvUHnZPKplh5c7fDMiK57U2RPnYSeM0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8f330aec736c4dfe8b3d08d8dee01c35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401425290833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9r5B6ckebE7FSvUHnZPKplh5c7fDMiK57U2RPnYSeM0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
