Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE198C2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 02:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BB3206B8
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 02:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HG9UM24D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BB3206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4406D6E101;
	Tue,  7 Apr 2020 02:55:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427076E101
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 02:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+5x04r8B12gD0mebZ1n37v4ZrrcgNRFiYNLfWOCYC7DcJfQBsL59qIk2TLBkLz/9DsF2P6UFQsaryl8tcPtlyzPxsB/jAos7yni/nsihL6YZvIG+8zu/A8pSPphK4gs0mEp/dxDKd9+6Vl5w/rfEno7bWZ/p6XOb7AfCjfSZ2PTi01orZmRIIg2rLr8WuRXa52nnJ9HGQ5NnIGrOBew+7v8cjlWIAGOQZu9HlSp9TCj3CcQ2W+t/ft3kjLjDAVT2T6UaOAaqNz39Oyq3tyV5HJKlq4L+GtnyB8ccCy6a9FCN/mYJ9h1Yj7Wf5eWvNfhmFO8Il7RdWDSF6tBw9X3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM2REpJjfBbyXJqpsrI7nz3yFKjXjkY4iquX+AtzLJI=;
 b=hQQIN33ZxclQIl3h46OsXPPOrscsik09db4NV7m0+UUOJ2RM+/5wLiqzMe5op5vZlwHcBrB/UDdaDdNjz3MXlytFl1vObigsPm5pbfv2LpW2MOUdZf1ZiKo4XETbDsJAjwrIdzRpl0qYjpCgi4ulmtUZAcs16DpWay51zlBwmUSIP0Yy2xusTtCZoifxwAKrKyCYubuldZc1ulIRo1tiPcjP3NiEeqs/dAyQ1e23+NkTPPGVDSZStXxn2WKZeKnVTguYEhN5qui7cU6HPitz+1SiyQdipTq1h8INdJKFkIWfefmFvvd2+uBeXwZdjx2AfgdmOVcigY06GJWFFHShMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM2REpJjfBbyXJqpsrI7nz3yFKjXjkY4iquX+AtzLJI=;
 b=HG9UM24DRQNIeydb6gRRiMVUz0+7Vgs9W8eSjQpmf32mZCBqRzYo0ePo9Z8nFlxy4do3o0fxE0lYE2owOZJp8wizSAcCnCsU3CSxq4+lmN8awMYbIK4Egi/uXjT/HKn2W+r5eu2umSXNOYdr9dKhH1OtlkaBqBcCE5R0Ibchn7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 02:55:10 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 02:55:10 +0000
Date: Tue, 7 Apr 2020 10:55:02 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the
 whitelist
Message-ID: <20200407025500.GA26341@jenkins-Celadon-RN>
References: <20200406194201.846411-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200406194201.846411-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.6 via Frontend Transport; Tue, 7 Apr 2020 02:55:08 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be27a9b3-1026-4348-0fac-08d7da9f1632
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:|MN2PR12MB3728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37286E44B4F68FC9239EF722ECC30@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39850400004)(396003)(366004)(346002)(136003)(316002)(54906003)(66556008)(66946007)(26005)(86362001)(966005)(45080400002)(6666004)(5660300002)(66476007)(4326008)(478600001)(33716001)(6496006)(16526019)(81156014)(9686003)(1076003)(8676002)(55016002)(8936002)(81166006)(33656002)(6916009)(52116002)(956004)(2906002)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RygfC63motf5mrdQ0FAXdknHOwxrHkzb3NAQDQPNs2qD/jd0/n4IsyVuCZwLqWg/QFw51n0yRoKXCohQqPpL4htV7t0yUd6CeUsNuHRO8e8yTHng4weAXJgPcAwWHtWyTIL0EBjvvOvlX+ziKokYtPWYzKcvVXbWYQt+bpJ2zIvvJ8I3EeGdqZDGyib6rQVkUZGJiLwGOWydxvBKbV/Y0MVwZEIq3WxICtaWK9gEucow4MA39wOu9R8S0nsKrcGwBLxFEu+arDycHtb0WZ/Q0PxY73DAx5u4Myb3zeNI6kxTy3KEeIG79R6Dhe0Nhdcv62yGqS5fwOcTVmZqhhcEq6z/dwmxlk40CglkrZB4InTSi3k6FGbqJWF9fDCgZ/SVVCaOXgeG7H0YDrAitBvJuXkqe63wzdjcwB4uxDnlAAJhMhqXFkop8j4Ld0GmDSzcz6RwKGiyoQWooe3pUgNOw5suvTPFXKgEsfokw0C5CZM=
X-MS-Exchange-AntiSpam-MessageData: 4dY+4whsSmsofuMvszk4NqIC49yFe+sRdB5I5nzU0GeSZmDDrQe+qpovKH98VbyuzMBWI30eike9v/xN0pICwuan53OvCRXplCmCI2n0L3AN2IDDo8t/MPpMR+Bvn7MYAVY6tDfbeW6dTTQZvJsr7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be27a9b3-1026-4348-0fac-08d7da9f1632
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 02:55:10.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HH8lEDBTOsV3/sSoD117GM6rqSlqdfJRVPgAkvatfqc0DRf8DwzMN5Ow9zXoI7e9spFFjgZRfDZBoCHA4GJk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
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
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-pci@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 06, 2020 at 03:42:01PM -0400, Alex Deucher wrote:
> According to the hw architect, pre-ZEN parts support
> p2p writes and ZEN parts support both p2p reads and writes.
> =

> Add entries for Zen parts Raven (0x15d0) and Renoir (0x1630).
> =

> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9a8a38384121..91a4c987399d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -282,6 +282,8 @@ static const struct pci_p2pdma_whitelist_entry {
>  } pci_p2pdma_whitelist[] =3D {
>  	/* AMD ZEN */
>  	{PCI_VENDOR_ID_AMD,	0x1450,	0},
> +	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
> +	{PCI_VENDOR_ID_AMD,	0x1630,	0},
>  =

>  	/* Intel Xeon E5/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
> -- =

> 2.25.1
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray.hu=
ang%40amd.com%7C9ed9b4e22b2744af197e08d7da629a76%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637217989343230053&amp;sdata=3DpeIQSu9dCwpMRzKyCkU%2BgGF=
LzDlwcvpmdDyGKzeSFQ4%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
