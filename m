Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEFC43215
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 09:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D83320823
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 09:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D83320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1D86E087;
	Mon, 25 Nov 2019 09:49:45 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750081.outbound.protection.outlook.com [40.107.75.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7756E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 09:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkJ9fB3zqVIdMPImrrSC9HbZlV28CjMDAnmIALyeP4E02H/yB3KDd1TOCRxwDnZzvYw8pXs4Mj6C6s/2oUHC/NQqboCwvAvxX4py3qSwiYQZCnA2eBz80CuIHzehDWbNXI63OkFQwPraApxnIGmxXNxVzp6k7c5+TfbmH1hXio3y/Vi7vez+3PpkyA/gm5Gf3XxkMt7PqZC2oSCia4TGkhRh4/mpI1omlY+21obReNjjRkCXqeOu0EdDXYNKvU+EPM5IMtaqm6prPf8tefeU2UNjUkwG8Rfxhyz3rCKG4p+0PottRUNSYSuyGHqk4blJZp8roie/TNUolLji4EXkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxUz1Qj9pP75d/mdmxvpcSVLU/1fOMWOosYx38lVrrU=;
 b=arzx1DplTb87RaY7ua+/hAkE+MTNl3Ba55GH7MbWo1ygeK8rzt3+VyKyHqTtYct0zSSPYUwJNeQtO+69Ewqf6OZ50PI3iMy9r7RqftEfnRi0kJFuA1Md6qsnxNzocXZl3lwLV8cus8HT+7eZ5t9Nvd1VFg4W8RZGu5cdBTr1Apj64tjf65ok7deGysHQIcWDeKHWC09WUxZ6HIS30g5BG+DcPx5aHo+Uk4iPqQ1Gn7lLrlXk8Q4P0/gW3EXSJK91/R/gxE83yuWBctCapKE9I5bhuIU5sAEkNI0OX+kTrbHN3bl0147kpPHWRulOGYo5B+m+/RcZwFOK8tlx6ixKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0064.namprd12.prod.outlook.com (2603:10b6:0:56::32) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 09:49:41 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by DM3PR12CA0064.outlook.office365.com
 (2603:10b6:0:56::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 09:49:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 25 Nov 2019 09:49:41 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 Nov
 2019 03:49:38 -0600
Date: Mon, 25 Nov 2019 17:49:56 +0800
From: Louis Li <ching-li@amd.com>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Message-ID: <20191125094956.GA18516@swae-HP-ProBook-455R-G6>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
 <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
 <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
 <2d828fee-b8c7-ec8c-f454-2574fd68ed45@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d828fee-b8c7-ec8c-f454-2574fd68ed45@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(47660400002)(189003)(199004)(13464003)(8676002)(14444005)(426003)(6116002)(2906002)(316002)(58126008)(9686003)(6636002)(336012)(229853002)(33716001)(26005)(446003)(6666004)(356004)(11346002)(33656002)(7736002)(4001150100001)(76176011)(478600001)(305945005)(386003)(6862004)(4326008)(6306002)(70206006)(47776003)(8936002)(81156014)(6246003)(966005)(81166006)(54906003)(70586007)(53546011)(186003)(16526019)(3846002)(2870700001)(23756003)(55016002)(50466002)(1076003)(5660300002)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1353; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad7d807-4a34-478f-f695-08d7718ccb22
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR12MB135393C16AD02A91D96DE574AA4A0@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sqajk3vDJ6fO/kt5U59Dy4B5jzNjvR5kC+vNhtpapPN4s7tnbnJ061S6pW?=
 =?iso-8859-1?Q?82u7O09AR/07Xhdr4NNK420Yf4PQeCx2AsTxYf5neuxkTn+AdcSHDk35GO?=
 =?iso-8859-1?Q?Ee+ME/CxobDyxTnWFeBkD8jTtEDKjXP9YjtawYe9tq8LceRgauxEpe9ODb?=
 =?iso-8859-1?Q?e42vkH+v3UOciCutPTb1ubkpIgOCTDaFk19dCdlh3lq6YOleT7j07zE2eA?=
 =?iso-8859-1?Q?EJdR6Jx+/iXU7toYmjGonc87GcXKTwgEQPz+84hZy8bKCCgKEuyu2bVW2n?=
 =?iso-8859-1?Q?9Xin1a20Vx0/7tH8Had0IWI7Z0NnNZHg4/V8Mbcj2CnBquKtyjSApPmC/u?=
 =?iso-8859-1?Q?ML8bPG+XISCFKctk0HRJc7SgtFo6N10CUBQkyozrYsP84L7a7Awl1QsRNe?=
 =?iso-8859-1?Q?cKuBnwGWIbY1FO4VEqBBuq+rPE3W2jchUbpg8LbEUnjcZ2gP9spKLKz7hW?=
 =?iso-8859-1?Q?7bFFHnZyCbxSGK5UqY0ukzq5ZNVAQu2XreYWoskw9Q1Hd5jto8lf9+o2t7?=
 =?iso-8859-1?Q?OoPsudwHf0vzQWJWKH3z98uBYXrQyIM05gNTqxJ2ZvFi/ERV7UX4ygTub9?=
 =?iso-8859-1?Q?48Fi5Qz62jMpZRm+HE1KfHurVdd7qHc6Dnx1299zA4cq7g/AJwFvcZINCZ?=
 =?iso-8859-1?Q?zKClIrYe2s3AlYNC8ZwPj2ZGIjJmLZ3z8EuNKfF3+yMINxWGPRRMtaUp88?=
 =?iso-8859-1?Q?bPbW9cct98r0P0P4kOgGZuExCQCRXnRr0vqxhP/bkTLQ7Fwnncs207ldbR?=
 =?iso-8859-1?Q?N8zHD2oldonh014ncfsKGHccb2/td/nVpyWyAfclIvNOfgdKhJ1Cusppso?=
 =?iso-8859-1?Q?XCI4Jr8XQPVB6KifrEmrjnj+oTBD+xy7o4y95Ex2U9+xhvGhx7rHWl63xV?=
 =?iso-8859-1?Q?ZgG7PX/EQoFNg+tpM+IM0dHkSLrJbAenXeryeqKM8X08kMHr8e2Tu8CFKr?=
 =?iso-8859-1?Q?8GZ8PK8xsBWLM/ItFuDk+gTXi7Mf0YDIh8WbqAn5zTWWKNemG34W/s9UWY?=
 =?iso-8859-1?Q?/NWqGlaXXe2xMUoyo/pfYCC5VcwkiC2Crca2qPoMNYFyUIL5QFSS5uQiru?=
 =?iso-8859-1?Q?EM8KmAnIWvjI6enV20fsl/vaOznJTkngd0B9jQxvE4zxMt8+PN9808xvSr?=
 =?iso-8859-1?Q?wnogSSglUGdfr+Z3zC6u9XK5X5DQMZl2tDJS+xpWdyoaFCZc85mIdNf9Nx?=
 =?iso-8859-1?Q?6mZ4rkueeHG9EzraFMae5nUEowHwBMtpAAq6mS3Z8xUiRhmmb5yAnwYJlL?=
 =?iso-8859-1?Q?Jyz3NUXicq/QP/2KMpQ5eTfbanKUtSLEXbyiwRgT49kKkdThpr109NW7FH?=
 =?iso-8859-1?Q?cvO5PrNl580LoXFCBP/ogm8TrJKNipfqQZC0FSAuFnI5D0w2RPQrhugbQe?=
 =?iso-8859-1?Q?LIjq8C44z1jlRJ1bzLYVV0odz54nOfLhIQgQQZaiveXJVDNMf49K1pDUMC?=
 =?iso-8859-1?Q?Os7RGOQq5q/PlX5F+76RnN9us1MTJ79T4gkCjp7VnJgBCFpbTsSiTOFLZl?=
 =?iso-8859-1?Q?rX0VqylgtPC5ecsimm5ND8zQ4EIGvD0q7peCGLm3iemiUnEajpz37hpKZB?=
 =?iso-8859-1?Q?mN2zeBFMw9eqRyLU6/MqK3bMj9I/ymqpEzTUOoacHQtGVX/r5vhIqXhCxR?=
 =?iso-8859-1?Q?gtRl2SV8f5NOcZUuGoT6X5QmFD5RxhTYQKOnBlWsYjhiqbUSqiN/0YQpDQ?=
 =?iso-8859-1?Q?ThxVwmG95g/3Z6MS8rwy1l3VsVUu1bx1DIvjrFFnOnP9+ylPRMJL+85p3/?=
 =?iso-8859-1?Q?xfX6GIO1k8gr4CUveWPm/URIdYvH60pRWizIxn/3IJzRJvGyNYISZhuABu?=
 =?iso-8859-1?Q?PtzzkEHIUZTpF92Usdek7YqsQU4ZN4C8piL8Z+G3Ds9WCdYJUaIXcO7Ekc?=
 =?iso-8859-1?Q?8hQm6gdi93dXh2OZl+YFRlheOp37dFPFIrhhA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 09:49:41.2790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad7d807-4a34-478f-f695-08d7718ccb22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxUz1Qj9pP75d/mdmxvpcSVLU/1fOMWOosYx38lVrrU=;
 b=GzYfO0L6t1fCz+1IDJlbYmafBLa1ZYqXAy+SGCzKk2GXFbv0wTKbLW98/PB74rHyR+G8bU/n3xXirqCvLR493aF7RHJnRlg/Qn/zpSvOXS4CwbcJVVI3g3OLGDNPbiiIEZ8uQ7BX1/Q7xcYJaltJZ9lOYlwO68nivc/HtXP82Os=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125094956.ys1Cu5iewltiu25jBTjnEdFUBrBg5zJwjP0Lw9dDnag@z>

T24gRnJpLCBOb3YgMjIsIDIwMTkgYXQgMTA6MzE6MTlBTSAtMDUwMCwgSGFycnkgV2VudGxhbmQg
d3JvdGU6Cj4gCj4gCj4gT24gMjAxOS0xMS0yMiAxOjMzIGEubS4sIExvdWlzIExpIHdyb3RlOgo+
ID4gT24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDg6NDc6NTBBTSAtMDUwMCwgS2F6bGF1c2thcywg
TmljaG9sYXMgd3JvdGU6Cj4gPj4gT24gMjAxOS0xMS0yMSA4OjQwIGEubS4sIEthemxhdXNrYXMs
IE5pY2hvbGFzIHdyb3RlOgo+ID4+PiBPbiAyMDE5LTExLTIxIDM6MzEgYS5tLiwgTGksIENoaW5n
LXNoaWggKExvdWlzKSB3cm90ZToKPiA+Pj4+IEhpIHJldmlld2VycywKPiA+Pj4+Cj4gPj4+PiBX
aGF0IGlzIHRoZSByZXZpZXcgcmVzdWx0IGZvciB0aGlzIHBhdGNoPyBDdXN0b21lciBpcyBwdXNo
aW5nIG9uIHRoaXMKPiA+Pj4+IGNoYW5nZSB0byBtZXJnZS4gVEtTIGZvciB5b3VyIGF0dGVudGlv
bi4KPiA+Pj4+Cj4gPj4+PiBCUiwKPiA+Pj4+IExvdWlzCj4gPj4+Pgo+ID4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPiA+Pj4+IEZyb206IExvdWlzIExpIDxDaGluZy1zaGloLkxpQGFt
ZC5jb20+Cj4gPj4+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTQsIDIwMTkgMTE6NDIgQU0K
PiA+Pj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+Pj4gQ2M6IEthemxh
dXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBXZW50bGFuZCwg
SGFycnkKPiA+Pj4+IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgTGksIENoaW5nLXNoaWggKExv
dWlzKSA8Q2hpbmctc2hpaC5MaUBhbWQuY29tPgo+ID4+Pj4gU3ViamVjdDogW1BBVENIIHYyXSBk
cm0vYW1kL2Rpc3BsYXk6IEZpeCBBcHBsZSBkb25nbGUgY2Fubm90IGJlCj4gPj4+PiBzdWNjZXNz
ZnVsbHkgZGV0ZWN0ZWQKPiA+Pj4+Cj4gPj4+PiBbV2h5XQo+ID4+Pj4gRXh0ZXJuYWwgbW9uaXRv
ciBjYW5ub3QgYmUgZGlzcGxheWVkIGNvbnNpc3RlbnRseSwgaWYgY29ubmVjdGluZyB2aWEKPiA+
Pj4+IHRoaXMgQXBwbGUgZG9uZ2xlIChBMTYyMSwgVVNCIFR5cGUtQyB0byBIRE1JKS4KPiA+Pj4+
IEJ5IGV4cGVyaW1lbnRzLCBpdCBpcyBjb25maXJtZWQgdGhhdCB0aGUgZG9uZ2xlIG5lZWRzIDIw
MG1zIGF0IGxlYXN0IHRvCj4gPj4+PiBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbiwgYWZ0ZXIg
aXQgc2V0cyBIUEQgc2lnbmFsIGhpZ2guCj4gPj4+Pgo+ID4+Pj4gW0hvd10KPiA+Pj4+IFdoZW4g
cmVjZWl2aW5nIEhQRCBJUlEsIGRlbGF5IDMwMG1zIGF0IHRoZSBiZWdpbm5pbmcgb2YgaGFuZGxl
X2hwZF9pcnEoKS4KPiA+Pj4+IFRoZW4gcnVuIHRoZSBvcmlnaW5hbCBwcm9jZWR1cmUuCj4gPj4+
PiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgdGhlIHByb2JsZW0gY2Fubm90IGJlIHJlcHJvZHVj
ZWQuCj4gPj4+PiBXaXRoIG90aGVyIGRvbmdsZXMsIHRlc3QgcmVzdWx0cyBhcmUgUEFTUy4KPiA+
Pj4+IFRlc3QgcmVzdWx0IGlzIFBBU1MgdG8gcGx1ZyBpbiBIRE1JIGNhYmxlIHdoaWxlIHBsYXlp
bmcgdmlkZW8sIGFuZCB0aGUKPiA+Pj4+IHZpZGVvIGlzIGJlaW5nIHBsYXlpbmcgc21vb3RobHku
Cj4gPj4+PiBUZXN0IHJlc3VsdCBpcyBQQVNTIGFmdGVyIHN5c3RlbSByZXN1bWVzIGZyb20gc3Vz
cGVuZC4KPiA+Pj4+Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBMb3VpcyBMaSA8Q2hpbmctc2hpaC5M
aUBhbWQuY29tPgo+ID4+Pgo+ID4+PiBUaGlzIGlzIHN0aWxsIGEgTkFLIGZyb20gbWUgc2luY2Ug
dGhlIGxvZ2ljIGhhc24ndCBjaGFuZ2VkIGZyb20gdGhlIGZpcnN0Cj4gPj4+IHBhdGNoLgo+ID4+
Pgo+ID4+PiBTbGVlcHMgZG9uJ3QgYmVsb25nIGluIElSUSBoYW5kbGVycy4KPiA+Pj4KPiA+Pj4g
UmVnYXJkcywKPiA+Pj4gTmljaG9sYXMgS2F6bGF1c2thcwo+ID4+Cj4gPj4gQWN0dWFsbHksIHRo
aXMgbGl2ZXMgaW4gdGhlIGxvdyBJUlEgY29udGV4dCB3aGljaCBtZWFucyB0aGF0IGl0J3MgYWxy
ZWFkeQo+ID4+IGJlZW4gcXVldWVkIG9mZiB0byBhIHdvcmsgdGhyZWFkIHNvIGl0J3Mgc2FmZSB0
byBzbGVlcC4KPiA+Pgo+ID4+IEknbSBub3Qgc3VyZSB3ZSB3YW50IGEgZ2VuZXJhbCAzMDBtcyBz
bGVlcCAoZXZlbiBieSBleHBlcmltZW50IHlvdSBzYWlkIHRoYXQKPiA+PiBpdCBvbmx5IG5lZWRl
ZCAyMDBtcykgZm9yIGFsbCBjb25uZWN0b3JzLgo+ID4+Cj4gPj4gTmljaG9sYXMgS2F6bGF1c2th
cwo+ID4+Cj4gPiAKPiA+IFllcywgaXQgaXMgSVJRIGNvbnRleHQuIFNhZmUgdG8gY2FsbCBzbGVl
cCgpLiBNb3Jlb3ZlciwgaW4gY3VycmVudCBkcml2ZXIsCj4gPiBldmVuIHVkZWxheSgpIGlzIGNh
bGxlZCBpbiB3YWl0X2Zvcl90cmFpbmluZ19hdXhfcmRfaW50ZXJ2YWwoKSBpbiB0aGUgZmxvdwo+
ID4gb2YgaGFuZGxlX2hwZF9pcnEoKS4KPiA+IAo+ID4gRm9yIDJuZCBxdWVzdGlvbiwgb2YgY291
cnNlIG5vdCBhbGwgY29ubmVjdG9ycyBoYXZlIHRoaXMgYmVoYXZpb3IuCj4gPiBCYXNlZCBvbiBy
ZWFsIGNhc2VzIHdlIGV2ZXIgZGVhbHQsIHNvbWUgZG9uZ2xlcyBsaWtlIHRoaXMsIG9yIHNvbWUK
PiA+IG1vbml0b3JzIGRyaXZlbiBieSBUQ09OLCBoYXZlIHNhbWUgYmVoYXZpb3IuIEFuZCBubyBj
aGFuY2UgdG8gcmVhZAo+ID4gb3V0IGFueXRoaW5nIHRvIGRlY2lkZSBpZiBkZWxheSBpcyBuZWVk
ZWQuIFRoaXMgY2hhbmdlIGRvZXMgaGVscAo+ID4gdG8gaGF2ZSBvdXIgZHJpdmVyIGdhaW4gYmV0
dGVyIGNvbXBhdGliaWxpdHkuIFRydWx5IHRoaXMgc2hvdWxkIGJlCj4gPiBwcm9ibGVtIG9mIGRv
bmdsZXMvbW9uaXRvcnMuIFdlIGFyZSBub3QgdGhlIG9ubHkgb25lIHRvCj4gPiB3b3JrYXJvdW5k
IHN1Y2ggYSBwcm9ibGVtLiBUaGlzIGNoYW5nZSBkb2VzIG5vdCBodXJ0IG90aGVyIGNvbm5lY3Rz
LAo+ID4gYW5kIHNvbWUgb3RoZXIgZG9uZ2xlcyBhcmUgdGVzdGVkIG9rLCBlLmcuIEhQL0h1d2Fp
IGRvbmdsZXMsIGV0Yy4KPiA+IAo+IAo+IEkgc3RpbGwgZG9uJ3QgbGlrZSB0aGlzIGNoYW5nZS4g
SXQgbWlnaHQgaW1wYWN0IG90aGVyIHVzZSBjYXNlcywgc3VjaCBhcwo+IFNTVC10by1NU1Qgc3dp
dGNoaW5nIG9uIE1TVCBkaXNwbGF5cy4KPiAKPiBIYXZlIHlvdSBjaGVja2VkIGhvdyBXaW5kb3dz
IGRlYWxzIHdpdGggdGhpcyBkb25nbGUgYW5kIGhvdyB0aGUgV2luZG93cwo+IHRlYW0gc29sdmVk
IHRoaXM/IEhhdmUgeW91IGNoZWNrZWQgaG93IG90aGVyIGRyaXZlcnMgKHN1Y2ggYXMgaTkxNSkg
ZGVhbAo+IHdpdGggdGhpcyBkb25nbGU/Cj4gCj4gSGF2ZSB5b3UgY2hlY2tlZCB3aGV0aGVyIHlv
dSBjYW4gcGFzcyBEUCBjb21wbGlhbmNlIHdpdGggdGhpcyBjaGFuZ2U/Cj4gCj4gSGFycnkKPiAK
Ckdvb2QgcG9pbnRzLiBNU1QgYW5kIERQIGNvbXBsaWFuY2UgYXJlIG5vdCB2ZXJpZmllZCB5ZXQu
CgpGb3IgV2luZG93cyBjYXNlcywgc2FtZSBzb2x1dGlvbiB3YXMgaW1wbGVtZW50ZWQuIEFzIEkg
a25vdywgaXQgZ29lcyB0bwpwb2ludCByZWxlYXNlIChQUikgaW5zdGVhZCBvZiBtYWluIGxpbmUu
IENvbXBhbnkgTi4gaGFzIHNpbWlsYXIgc29sdXRpb24KdG8gd29ya2Fyb3VuZCBzdWNoIGEgcHJv
YmxlbS4gRm9yIGk5MTUsIHRoZSBzb2x1dGlvbiBzZWVtcyB0byBiZSBkaWZmZXJlbnQuCgpXaWxs
IHRoaXMgY2hhbmdlIGJlIGFjY2VwdGVkIGlmIGl0IGNhbiBwYXNzIE1TVCBhbmQgY29tcGlsYW5j
ZT8KCkxvdWlzCgo+ID4+Pgo+ID4+Pj4gLS0tCj4gPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNSArKysrKwo+ID4+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gPj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+Pj4+IGlu
ZGV4IDBhZWY5MmI3YzAzNy4uNWI4NDRiNmE1YTU5IDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4+Pj4g
QEAgLTEwMjUsNiArMTAyNSwxMSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfaHBkX2lycSh2b2lkICpw
YXJhbSkKPiA+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGNvbm5lY3Rv
ci0+ZGV2Owo+ID4+Pj4gwqDCoMKgwqDCoCBlbnVtIGRjX2Nvbm5lY3Rpb25fdHlwZSBuZXdfY29u
bmVjdGlvbl90eXBlID0gZGNfY29ubmVjdGlvbl9ub25lOwo+ID4+Pj4gK8KgwqDCoCAvKiBTb21l
IG1vbml0b3JzL2RvbmdsZXMgbmVlZCBhcm91bmQgMjAwbXMgdG8gYmUgcmVhZHkgZm9yCj4gPj4+
PiBjb21tdW5pY2F0aW9uCj4gPj4+PiArwqDCoMKgwqAgKiBhZnRlciB0aG9zZSBkZXZpY2VzIGRy
aXZlIEhQRCBzaWduYWwgaGlnaC4KPiA+Pj4+ICvCoMKgwqDCoCAqLwo+ID4+Pj4gK8KgwqDCoCBt
c2xlZXAoMzAwKTsKPiA+Pj4+ICsKPiA+Pj4+IMKgwqDCoMKgwqAgLyogSW4gY2FzZSBvZiBmYWls
dXJlIG9yIE1TVCBubyBuZWVkIHRvIHVwZGF0ZSBjb25uZWN0b3Igc3RhdHVzIG9yCj4gPj4+PiBu
b3RpZnkgdGhlIE9TCj4gPj4+PiDCoMKgwqDCoMKgwqAgKiBzaW5jZSAoZm9yIE1TVCBjYXNlKSBN
U1QgZG9lcyB0aGlzIGluIGl0J3Mgb3duIGNvbnRleHQuCj4gPj4+PiDCoMKgwqDCoMKgwqAgKi8K
PiA+Pj4+IC0tIAo+ID4+Pj4gMi4yMS4wCj4gPj4+Pgo+ID4+Pgo+ID4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+PiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+ID4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+PiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiA+PgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
