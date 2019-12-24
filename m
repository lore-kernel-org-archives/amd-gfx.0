Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB7DC2D0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 03:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59873206D3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 03:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VH+yeyCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59873206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D201E6E055;
	Tue, 24 Dec 2019 03:12:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7841F6E055
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 03:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtUyWbeMCHch+ZaDzaehiOSp8mlRJ41oaCQUnBnFpvDHo9Uxp0CXupyBlJd6mrMKOiXwWpHVoyGTALqhR7tGGNl/uZBxdTX1lm5x85kGuv65nfv9H+KjLojLeG9fPyWnZ3qIIlITJHc0Ms8nfytqXdVRHgD3ARxj2MTGDyqljPmX/ABFk9IXcWFhjq7MYty8hGZqFPE5LYQg9hPrAWLEur/5k8VaxpIUU6OE/uidp6nu2yLVQj+p7XDrKH75LNuIGIce67Q/sGne3nVGDI0zrkju7bqxyIRMrh+qXJRSQ2HuPFeKliqOQrcpUbXiv/o0/l/Ptw6VOhx8nojSQEepIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daGLaHeYZZVSgOtkxFjbe1t1vtGeLuwHKF0wxxG4yMg=;
 b=iw9/BC33w2UxlZHMWoXygsVtoSDHizs+1x443UdAxyoNR3c9+vxh14jXhZmzJz2gVjhfGUWTnI9XGZVrxpRyNTcQIFhmvP/HRZFpsKNuQrceUkLPdNcmplhHqVP96Z3Or3va6LJ2ocL1j/0YTebyikpKjRmgZYJFI1MsVXIytb00jE57aThW6ejjRUh/0EC9P6PSOwOgHj167UgjuZ6FARPWKgrD3TXAP18kHnaaPpbnRKCYDVWj0lHz9VT+oZUCO3DW8Ap31jbNwj3tVjVPREd2DdhwOmUjR++ud9qWxDSYz99bkVehxcgKxJRN8ZNQi8jKebNbECj2T1Jvym4cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daGLaHeYZZVSgOtkxFjbe1t1vtGeLuwHKF0wxxG4yMg=;
 b=VH+yeyCH0IWUP0Ke4IQTuoz09domuz6cVRXSamdWJd0UuJlubT+mhI2gK2YvLBhMlXu6VmNNiUO0GK7WS48DKIvwb/aWQq94NLLyqxSH8reoh3cHCt4EZm46drbUmntLEIjYxTmX2iZjzJHJY4R1X4eMhhhJdw2vLDUFanfz8rU=
Received: from SN1PR12CA0112.namprd12.prod.outlook.com (2603:10b6:802:21::47)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Tue, 24 Dec
 2019 03:12:34 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by SN1PR12CA0112.outlook.office365.com
 (2603:10b6:802:21::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend
 Transport; Tue, 24 Dec 2019 03:12:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2559.15 via Frontend Transport; Tue, 24 Dec 2019 03:12:33 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Dec
 2019 21:12:32 -0600
Date: Tue, 24 Dec 2019 11:13:18 +0800
From: Louis Li <ching-li@amd.com>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH v3] drm/amd/display: Fix AppleDongle can't be detected
Message-ID: <20191224031317.GA17716@swae-HP-ProBook-455R-G6>
References: <20191211073338.25373-1-Ching-shih.Li@amd.com>
 <30bd45bb-1351-413d-a8fe-a6a1737d3ad3@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30bd45bb-1351-413d-a8fe-a6a1737d3ad3@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(189003)(199004)(33656002)(6862004)(33716001)(336012)(4326008)(4001150100001)(16526019)(26005)(8936002)(81166006)(81156014)(8676002)(186003)(6636002)(316002)(70206006)(55016002)(5660300002)(53546011)(478600001)(70586007)(426003)(9686003)(356004)(6666004)(54906003)(1076003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3895; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e663ef-017b-49fc-ea8b-08d7881f1ee8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3895B94EC076194C3EA6AB09AA290@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0261CCEEDF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raxBQA5PCzSbJz3+0+VF7uDFQx8XnWk/UnSWX0sXRIBmdXZXYr70455ysmbtBgs3kurTp1Pmy3mmXtf4v+kxmRNsabmzis3ahXJZ6hURaFHowDGIdLddVioZJHi5WcP0t4pQrnVgtTlK1DZeuVS/6za+S3oJRUzjmSCYtUW8JNW+jZd5Zn4v9yhMn332505asC0CQY7g5krTbEScsUz1Uvw50ctOS5p4v8hdho0AFqq/cs1antKAZjpgECH/t3z9UlV1+ibWmd5Wf7k2WJ4KwZzD3GJsSbNb0A9VJPZjRYbHuegofrYkYjfMtma5jXsnK51GEHuoKRn83nq0xV1dbb5sgrNdvG5DCyVKillmL7H4s1bZM2cPtVSWpZuKC27Lnfl/t3qset0KS+e8WI6FCOgXKnQKoIvowFOJ3Rb9o2axF0/gKQraql3DQdFaL9GK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 03:12:33.9738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e663ef-017b-49fc-ea8b-08d7881f1ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org, Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 17, 2019 at 10:57:11AM -0500, Harry Wentland wrote:
> On 2019-12-11 2:33 a.m., Louis Li wrote:
> > [Why]
> > External monitor cannot be displayed consistently, if connecting
> > via this Apple dongle (A1621, USB Type-C to HDMI).
> > Experiments prove that the dongle needs 200ms at least to be ready
> > for communication, after it drives HPDsignal high, and DPCD cannot
> > be read correctly during the period, even reading it repeatedly.
> > In such a case, driver does not perform link training bcz of no DPCD.
> > 
> > [How]
> > When driver is run to the modified point, EDID is read correctly
> > and dpcd_sink_count of link is not zero. Therefore, link training
> > should be successfully performed. Which implies parameters should
> > be updated, e.g. lane count, link rate, etc. Checking parameters,
> > if values of those parameters are zero, link training is not
> > performed. So, do link-training to have detection completed.
> > 
> > With this patch applied, the problem cannot be reproduced.
> > Testing other dongles, results are PASS.
> > Patch(v3) is verified PASS by both AMD internal lab and customer.
> > 
> > 
> > Signed-off-by: Louis Li <Ching-shih.Li@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index 7372dedd2f48..6188edc92d0f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -725,7 +725,9 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
> >  
> >  		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> >  			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX &&
> > -			reason != DETECT_REASON_HPDRX) {
> 
> Do we need to drop this line? This looks like it'll break the previous
> fix here.
> 
> It looks like Abdoulaye added this here to fix the 400.1.1 DP compliance
> test. If you can check with him that your solution is fine and make sure
> to test that you can get a consistent pass of 400.1.1 over 30 runs I'm
> okay to take the change.
> 
> Harry
> 

Thank Rickey helped to verify this patch. Confirmed that 400.1.1 failed
after applying this patch. Abandon this submission.

> > +			link->verified_link_cap.lane_count == 0 &&
> > +			link->verified_link_cap.link_rate == 0 &&
> > +			link->verified_link_cap.link_spread == 0) {
> >  			/*
> >  			 * TODO debug why Dell 2413 doesn't like
> >  			 *  two link trainings
> > 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
