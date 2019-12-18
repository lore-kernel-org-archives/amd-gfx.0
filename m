Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06929C2D0BF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBAC2082E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ERD8AkW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBAC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F0C6EA61;
	Wed, 18 Dec 2019 19:41:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AE86EA61
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 19:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBoXdPAPguTxrE5KA7u1hv2zGyI77ZDfKk7I6t7smTopBcxXXgep48XEv0n/Mwsw6YVKGoUM3bYoDmquKoEdiYNr4RdheAWtCkmlf3v1a2A1d4WmeeT4Cmb+2GYFe6k3qVKWEpV5zw72wTmTbV5hVJLZs2KDTjLOfg1pu3LSWibBxQ9FVhQuq5yqxraHVR/Ol7pg8v2ms5tPmpReVtGzZhltVuDIgA8ES0n/LCBB9mFzDu2PpKmG1K0AGpQYUP7f6xGWuJ9/CAPwX1vPlO77zBaHKeiI5ftOVYCq04AwKECr0POed3ujhJPjM36CEv1+RoTJymyHTqEvjbHep1SiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfDK4u/rV7VukyTDYd5xBvspus1+xPzteUG8yTWEU30=;
 b=ecMKCNQjV3aYUVjIy7Dm2Hrx4wABDEMJvBGRBQD5QMByDRSSU+esvh0P2+YE6IFfltjl/CZ5nv/gFaA9QguBQJ66yQi0qnxUn9JCVaPEGV1dpxWOUcgC3MdD2u+C2lo5c1dPdKWpR0XEcKwBHU2uhnS/mmC+vyt+IkW2N9Vd9DTvCUAO4fY81GCiDm54XbeawGM4+ya15AEacGhPFdf6k7rfW/Fv4r5QoQlMA9NYOdgCPG9nfxFZQBR8lU1iKJn77kDLDugJH14lD0jkB16OE5san9IaDITphpOzswHL3BXSAnRnJ2JBQDMO6llNDgk7qie9D6KPKpdHpbV814IhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfDK4u/rV7VukyTDYd5xBvspus1+xPzteUG8yTWEU30=;
 b=ERD8AkW609sp/sRPf8eMsRtKmEijKDwcojc/kGfjA6RRjKcqmn6bhyc8zlrRiqhr4wjU48IKikCLxWkPUKvqzebR9MgKU6wA5PQZorwUj9h+i09NfWOBJXvoPfPZPkcOR9bccmQl6t/SYavrullpyRiP4WFBbEanpklSJeBsm0A=
Received: from DM3PR12CA0116.namprd12.prod.outlook.com (2603:10b6:0:51::12) by
 CY4PR12MB1431.namprd12.prod.outlook.com (2603:10b6:903:43::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 19:41:37 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by DM3PR12CA0116.outlook.office365.com
 (2603:10b6:0:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Wed, 18 Dec 2019 19:41:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 19:41:36 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 13:41:33 -0600
Date: Thu, 19 Dec 2019 03:35:06 +0800
From: Louis Li <ching-li@amd.com>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH v3] drm/amd/display: Fix AppleDongle can't be detected
Message-ID: <20191218193506.GA8046@swae-HP-ProBook-455R-G6>
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
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(189003)(199004)(55016002)(26005)(1076003)(186003)(426003)(5660300002)(33716001)(6636002)(478600001)(356004)(9686003)(6666004)(2906002)(81166006)(70206006)(81156014)(54906003)(33656002)(16526019)(70586007)(316002)(53546011)(8936002)(6862004)(336012)(4001150100001)(8676002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1431; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af7ad26-bf7a-486f-f1e4-08d783f24b36
X-MS-TrafficTypeDiagnostic: CY4PR12MB1431:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14318EE61144711C473D852EAA530@CY4PR12MB1431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WM0AK26bmFAARSg0/NuyAuuOgAmZTwIBcbIN6FLY1j9gTYSPZ9nAvRYby2ivD/TwiXm2F9N6fSOfWqnKFhIvY4sg+dY95Wane78SV64S6OE094Fd0gP77hwh6akmH60hiGa6Fuvnkr3Kucw3H5i9RUcqNcGg26cADtmPYODg89wVBkEW/USMRHwgrDfTBPZ7Dkon1aplcwsHx/b+tdnAadB9D5qVXc16BV80s/uaHqEMsJp6PWxnsHelkSKEhqY8RsxT5Whkgjg0zt7fnXlbEBFcepzyDk0XQH2alocrX7Xto1vIUDaEVCZ6s3O8SKM8P/btVcTZQBKRBohtC3UIQHmqjYQv4b8wSHCrWin9l6JEm210Q+5pOCEBYhQUJKnh6qUTaDglaR7nQXbfaHwrTq++uzxd+pHKnbd2cLlbiioRhj/m2kmuhFC89TBQ06JY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 19:41:36.1849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af7ad26-bf7a-486f-f1e4-08d783f24b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1431
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

Yes, need drop this line for this fix. Good to know it may impact 400.1.1.
I will verify it with this patch. And update test result.

Louis

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
