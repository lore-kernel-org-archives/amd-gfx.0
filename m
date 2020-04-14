Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02175C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FED02075E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4gwBDMsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FED02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249186E445;
	Tue, 14 Apr 2020 02:43:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2C16E445
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 02:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8D0m924WkU4rj4FRFebcFPHUpXvwvmDcMZqILMqyX5EnSdvokmblOHyTpHZDsti61iUewznuon7Ud0RRfdADvxD9ZizIXDw42zpXqrBQF6PJuaKzrdbYCe3NKMaeu7Y8q0qZHf51J1KW1xa4QIkuIlutqPXfAAMKieF6xl6r3BtN6qzlbWms6T5n6PUJJOpwifMl0Cff1wYbxTdkgyUh7A+KeBDHhBt0ZYwSfgPaBVlnZrl4/pSK/TUKtCFz3jrqf9KhUTxn8voU1Bz0rE8/drHu8fimNxg12LQuDlvRhhgUv0qY4DAGmCUfj6E8qqA9Q5Mu5DsEthpUjJPcWiilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4JQANMfuJFz3znAXorCSTD2BVWa9FQXPZFTncmJI6M=;
 b=oAZHZcjXGF1PgFEcvMcJ79zKvu/UfIj/1OgwyP8+ot82og32lj7Mii5GALX0dDgEXT5LrD2dkireSM9gmy24Bgn6+8OPsolt0+ZFoNEeJws6SDGzRLnh9uwYFutyvrKLe8vH50qeK7DDThOtRwFIloI3wkA0ov79Lz0opVJa2sb+v9eIDmJaRD7hL7nj2AK/8M2HFq5HwAdf3V9OXjY8+LNsseLgJC6QrTcAqjjhqK5cqtbCgVkkJOnnR2L47WO7NzFtAIJajWPAaIq/AdqqlU1yJiQKqq4dc3z9tp9w2l5GQGlbacp9UKpk2hwo+1MZY1ZJE3Palk5xpJVIFOuSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4JQANMfuJFz3znAXorCSTD2BVWa9FQXPZFTncmJI6M=;
 b=4gwBDMsV4jOj9VlG1UNiulbBezx96VQ+zKdje83DwsZ3J4UJWn4ycJN2X63ZIjPR9RSstuUqfVtsUyGEnVGx1a1Wi48tH+xwG8x93QxYOT3GhnG645N6D+QoXfEsmIAWp4NDvTi4YfmzO9E/pb72CZ+SLJ8vGCBuAQkzNX0aawo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 02:43:04 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 02:43:04 +0000
Date: Tue, 14 Apr 2020 10:42:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: add gfxoff quirk
Message-ID: <20200414024254.GA9204@jenkins-Celadon-RN>
References: <20200409154253.77102-1-alexander.deucher@amd.com>
 <CADnq5_M6JA5vMbSUyweHMJ++hmk3ynWQ2jEvqwUFz8puPhAE9g@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CADnq5_M6JA5vMbSUyweHMJ++hmk3ynWQ2jEvqwUFz8puPhAE9g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 02:43:02 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c126fad-5d99-4f4b-5156-08d7e01d8e01
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:|MN2PR12MB4256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42564F512E6DCB8CE6238845ECDA0@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(86362001)(55016002)(52116002)(81156014)(53546011)(33656002)(1076003)(2906002)(186003)(5660300002)(8936002)(8676002)(16526019)(26005)(33716001)(66946007)(966005)(316002)(6916009)(478600001)(45080400002)(54906003)(66476007)(6666004)(66556008)(4326008)(9686003)(6496006)(956004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5BxwsPMDtieDZqcTc0Kw07anZrebid9YjpV4pkpxN7+8GXco/xjCB1cVMdeNNzmTc+Ac+9Mn2Z6oFW3eZK4nDkwlbhcjgS8Rn9Db1Nud/EGQzLN7bBxwbofQnp98AyBSLM5rZ8n8XpuxM2GgI9XRax4b2aa9f97evuDySJ6aNtHnfmfJuN9xnBpmw9HInJfJBejxgfnO49esMFh3y6g9q6y/iMgI1OMWZNUftemdcSoDZBx2yXJ1K+XOiZOVOrHk6FxYvibnjeQ7WwBuEDjV3445e7eFnAHJKhrvLaX/5WJbA8nU9Y5Goy4XLTgQOomz8C+y3sqw3x7+DzLfb8Fx6UcHkWt/ht+YVThguMuxsmUTP0Db/4ucS4YKw6QnKQve7EsyzMBMY+3jLSjjDYyacslzs1vn9SJZISGXpFHR1GW3s8hEMQ4W7a+GExN5RhGeGObVv+i9uQtsBnzfbwJK4Se2pIskIzJe+mEH/IWXeqGFeq4EZSdyDf2tp31IV/OLHWQFOjNqgG8cDw4MtSKXQ==
X-MS-Exchange-AntiSpam-MessageData: aHYl0qP/IQnpV7vVvH+LWyeQntQLtQGhHJUOlqBFO7Is5Eb5Ekg3TE1pBR8sAP8MHlFIRbHIi55qUJnG5CZgoVE3Y7Ghu9HnW53f9VUiuv9Z/tWtPX7nVy7OeJt8CIpoy1SjYxMHTxFp7edA2lzCsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c126fad-5d99-4f4b-5156-08d7e01d8e01
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 02:43:04.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXtoZXzw4Ynq9+eVBW0QP3C+EBQYGIp9jFy3iVy6W2tBRvbLM1JzMUAJ80AQDXq61Kx3NOAtVOMFDAdvoSwzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 13, 2020 at 11:02:22AM -0400, Alex Deucher wrote:
> Ping?
> 
> Alex
> 
> On Thu, Apr 9, 2020 at 11:43 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Fix screen corruption with firefox.
> >
> > Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D207171&amp;data=02%7C01%7Cray.huang%40amd.com%7Cf75dec23c4b04383199e08d7dfbbb4c3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223870207754970&amp;sdata=5vPHypd4xqJd8CvmjRMfX3%2BPfmXjZHFkZobgvL4uOto%3D&amp;reserved=0
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 1d18447129b1..e14ff65ac735 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -1231,6 +1231,8 @@ struct amdgpu_gfxoff_quirk {
> >  static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
> >         /* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7Cray.huang%40amd.com%7Cf75dec23c4b04383199e08d7dfbbb4c3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223870207754970&amp;sdata=OsJ3VfUdU1APJ%2BJhIgrzoqAZ%2BjP0YL1gwf3%2FAnHJnDk%3D&amp;reserved=0 */
> >         { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> > +       /* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D207171&amp;data=02%7C01%7Cray.huang%40amd.com%7Cf75dec23c4b04383199e08d7dfbbb4c3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223870207754970&amp;sdata=5vPHypd4xqJd8CvmjRMfX3%2BPfmXjZHFkZobgvL4uOto%3D&amp;reserved=0 */
> > +       { 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
> >         { 0, 0, 0, 0, 0 },
> >  };
> >
> > --
> > 2.25.2
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7Cf75dec23c4b04383199e08d7dfbbb4c3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223870207754970&amp;sdata=Vpz2bX6Dv1VEEgiOxFYaaKqs%2FB1ksl5LBu9v06myyHo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
