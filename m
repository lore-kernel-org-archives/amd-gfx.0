Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EBC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 12:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A92261492
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 12:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A92261492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E335B6EB18;
	Fri, 29 Jan 2021 12:51:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067CD6EB18
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 12:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVCznolqYLTq7tkgzamZqFcis4jCbQLOCyXfQj4PVfAlgQo28K/Whj1wtkCTZdrQ6IqvhCfKeKRKFgEuxIP1WXK06LUsCujSWcO469rpsNfK34wknZeBHW9KIHpekSm2799uw7yqS07NqQiSLU+y9Iuo6vDz4tSWeB0CxCJNpiy+3TjJX+xbMRjfz/Lleioh3DE5/YxUUCvTHVB7E+2IIF1ErmA2H7GtoZnrIu4YR/+BC0NaB8DB7ys/OscOou2O1nNR3lC1MXXZs3DrzFqAkY26WHbAbH/BsU9SdEZ4PajZpQJWmpLNECva5EEbqgKTarWnW4hIKq9PaQHUK2b3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y48LL8vFCDI2pvZ/rNhp1fl3RjT7R3bIcLOidSw1IXU=;
 b=LahOh1k0n8u8usJYlm8y9awSl/zvQ5KHsDA6STEjfBD50ZKcC3dgX8sReJxmVajMtmlYplkTnqV6j6PUkfcTX8vHNqQiHhVVrClEUVbMmMCEO+gWFHERVXRDRBIdmj1bo3maWajy55GubfAdlKE0JGMLUUGJcxpegRiBo113x1u8z9hQQDxY2mjVllKfzlt4NmcULlVYib2Ch/SA9f82PycYZFruj17rsn40qvvPbu2g3lSoYGblqtLSldythsemF2e/yrcaj61oro6SpnXhEv1F1IDTtO4LL0hXe+BDz6MMThra4eQiv6qJ+cJAKHpIcpEwcAQfse3pA7kr5eb4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y48LL8vFCDI2pvZ/rNhp1fl3RjT7R3bIcLOidSw1IXU=;
 b=bYzEVGQTDdXpUX/tdIXP4U8KF42wzRMi7k7ef27uWQdtHq9zs9d18wc8R3PB0VBRNKbetughXt0rCDDPCqLyFZ4vVeLcEVsfwE63FkYeuqocQ9fHgVJ9VLAWthIKNixMzla4d2grtBsTY1mJxfqVczrH7TO70ciyPi/XNlVhZys=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR12MB1306.namprd12.prod.outlook.com (2603:10b6:3:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 12:51:23 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f%6]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 12:51:23 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Messinger, Ori" <Ori.Messinger@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu: Add Missing Sienna Cichlid DID
Thread-Topic: [PATCH] amdgpu: Add Missing Sienna Cichlid DID
Thread-Index: AQHW9jxkSno7hbFEX06Y6elImO4zTao+jk9Q
Date: Fri, 29 Jan 2021 12:51:23 +0000
Message-ID: <DM6PR12MB33246111CB0DDA74A519136885B99@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210129124250.24700-1-Ori.Messinger@amd.com>
In-Reply-To: <20210129124250.24700-1-Ori.Messinger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-29T12:51:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8930ef9b-e488-4bea-a9ea-a5c02dbe3089;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:dc6a:d915:bc29:aa53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6d1e1a4-a9b5-472e-9e61-08d8c4549530
x-ms-traffictypediagnostic: DM5PR12MB1306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13061FF8704E705BD9F7775F85B99@DM5PR12MB1306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvT2zRD0pa4nwYf+eDno0iEVHemYFi0W+b00sDKjOntpu2lbWCCKzNVaDnlrzclshbNphWh165Nno/tDppxW5cWoMCp0oK4W0vRYoaC6XTOfp4j+vd3Hq8w1cBB2Jz3wzDTchpqZWrEObrN9AJ6ZGHVf+ISGh+U7q/ECSX669Yc/PxYHMyR9SoA2AUBb1sDY/9WhKEpQrvTCPiNl+rHg92EgE+UX3KVqD8U+9JpL0q+rP1iayRcfF/R32GdJhrILseU7h9RhMAwtGz4XKDbj24Rod+NYUkxDT6lmaNIwTNfvoLBpXF3aNmG/07OJC65ORS6+BMqrTxCupy4Y0mlu6HKNcMWqgvP+ZM/GgtTqWJpzvh3rpDQ0Lp9nkIpynm2AGAM3+IIx/waW/usvJKqiSGRD8dNkjzB1lZHGLv0/N7ekz2rbOzwbOSmDBgrVFGoSh+owfDcKsuSn/S7NWB+cURP+gMR+6vkVLWgNCoBCwRJdWFkvZn0JA7WvCvxoG3Fo24GtGxJ6RvpiJ1L0Rah985M5VJLBXsY2xaE7OSkxs+NPqXAR27iDSK3P85Ws+Tnr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(186003)(55016002)(8936002)(66446008)(66556008)(52536014)(33656002)(9686003)(83380400001)(8676002)(2906002)(76116006)(66946007)(71200400001)(110136005)(316002)(4326008)(53546011)(966005)(45080400002)(86362001)(64756008)(7696005)(6506007)(478600001)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aXxakCDVQWPc6VdZ6wyZyD/L4RzA6M0kxx2yyNcsyVKxhVNFZJnr6/4TGUle?=
 =?us-ascii?Q?kJEFs76VsCKBtAT4q34pWrM8Vvk1PzH9I2sk+nYDk7d5umNuXyeAuyya51wh?=
 =?us-ascii?Q?jYRTx5+0s9lByU98skdpF7JBwiqgthmKJskLgJZ2Npj9vIQw8we5yOCtWKTM?=
 =?us-ascii?Q?VAGKZhd5TDqiDwGbCOL3ESeSEGats8UM1WXsAOHUE644lj1b3dgX8DQY5iLy?=
 =?us-ascii?Q?qRt4jjGxVu12DymDSDfCSDHUne9FYcS/0zSKdTbnReU1KCT1wpc597ex1mxx?=
 =?us-ascii?Q?r90npwtsbJd0y4oFBm1Q/WgJ/rkEA0gBFTzJoAMPiNkJ/99m3fQmdB/3X3Du?=
 =?us-ascii?Q?GV+65rzRN8HJzPDmGFLboxF72k8OD+cWMmRoDzlS+8IVUZpb26bmxfkjFqGp?=
 =?us-ascii?Q?rA1/sV/Zi+w+9s/Ft4wSFMZ4XEzN2uDFNmQ5uHz5eQt4oHsrowprZyFJyd8j?=
 =?us-ascii?Q?5sVXOIV2GGge8t1Fau/EghDvVVEXCqXx7dVasIepsUwkiW12KU7WLgTXUlJH?=
 =?us-ascii?Q?9O/Gd3rnP6X2teybAVnWKmWaWEZmivRiZlEcUeNALI5mNDpLLimr2E/eqtTb?=
 =?us-ascii?Q?3FcdVsOmr24AfmxW1JIwFbNQYCFsFwzJNNvxkbqJXgTBlmgML2frcMb4FZfT?=
 =?us-ascii?Q?3d3NTgpWv4jtXcIhuQ0HPqkpqWOa6HXQ2BTeng7kTiZMeoMxbjI3wBqsi0hU?=
 =?us-ascii?Q?TIm30Rgku3WtdVfYNMI0ufBLAyEK6C21lcz6D8gHhfUDYSzmxbBMveAITtaz?=
 =?us-ascii?Q?b5DkqbhlpKXGPdA7fknWLGAwueGXF9Eq3nFFMpUC8l8TL8o7f2IBgMt4htlH?=
 =?us-ascii?Q?1t8q6AlsI7shHf3ZFQ1p4+AEyaXgzZwtW6kWQhXkTV/DryeP6IocQh0bxbQP?=
 =?us-ascii?Q?ABs2ffdr5h5+kgXFodQ8pZKRXaAJvFqROJWWd3xmDTwqT6bdGm7yDkJLPaaC?=
 =?us-ascii?Q?V1Xfgy+OHcS3sGyIhSSvttAU2nTTSpNLf7GuCop9iBK0Ohx4FRQiSF9qkYmh?=
 =?us-ascii?Q?12XR4UvWiTG9DgQUpjp6Lrm0DtzowAwtzY+OzdRZ0PMvZv1juK04yxGlGdeu?=
 =?us-ascii?Q?AwkprU7oojOIcVDbkjMjITKDQA9b8XxNFn5cwk0krBHxKRQCNWxxu/3oRDmz?=
 =?us-ascii?Q?u9XUWqM6yT5r?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d1e1a4-a9b5-472e-9e61-08d8c4549530
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 12:51:23.1414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wh5okClDGUS199A4QoTWvhORCUuuEhPz+/cSn9Vb7HlDyKToNRoARWIDL8iIZh1hfsUjTEQ/Jzg8DxzlGqK3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
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
Cc: "Messinger, Ori" <Ori.Messinger@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ori Messinger
> Sent: Friday, January 29, 2021 7:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Messinger, Ori <Ori.Messinger@amd.com>
> Subject: [PATCH] amdgpu: Add Missing Sienna Cichlid DID
> 
> The purpose of this patch is to add a missing device ID for Sienna Cichlid.
> The missing ID "0x73A1" is now added to the "amdgpu_drv.c" file.
> 
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 529dbc566f68..864cc69997dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1094,6 +1094,7 @@ static const struct pci_device_id pciidlist[] = {
> 
>  	/* Sienna_Cichlid */
>  	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
> +	{0x1002, 0x73A1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
>  	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
>  	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
>  	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Ce9aadc20683e4e7fc8ed08d8c453
> 8570%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637475210302531505%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=CsPAT1PUXy1hUd2fCsDbTRcAVXfnUID%2FbacmbyyQBc
> I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
