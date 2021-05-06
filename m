Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C99C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 03:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D81611AC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 03:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D81611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F806EC96;
	Thu,  6 May 2021 03:39:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB136E0BE;
 Thu,  6 May 2021 03:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxJLaj2sD6dPD7CI9DGI1UAIECnNQASsAJ5ngZzb5ppeiWnwUfi4Tu4+lrPMkNFz1L3m5L/WPVB78OsFNXWhKhDvXRcyjVgMJjjEsx2I9PWgF6ElR9I5JxvW575ZHD37l+pmyzjapzQ607w6Ux7Lt1rhk+sejIaxNEMF8AzYE6O7p8Fi2LV5/9JCH91NfyPYKg/1IrRCQpNptz+x5IZPbm+RZx+le8fjyJMD/BqZuIGggFzudQLQiayfdI3nQxz3/vSwK5dr6c0w633l7YSQcVPpnH6q8PAmigFQeiG8JMKXSq11tKw5m4VHPQ4PMhGVFLC+tsXu/YsSPuK9hS93hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjOk4seMZZwoGNJH0/Ojbrpzk3ewpvN5Zr8aQfd8dLM=;
 b=ewBhc3FzKjG0AomnuUUm6C+0cBGxlE1PR+J7cATlcThDj17tJf3Iq2XXhwXlBHedkC3bsQ2+23haqG7jZ35WCn8t4wm1/HI2DVATWCiq1eqdavEtqNWGuf4iW2bKkaZaqoEKRk+pFNV0z111qSOtRXkf5L5txBgeD2dPI2zwqATy1bkZhddCb+wh+Q5EWDYsYeXxzhLUZyjBrTTXIOY4x9Ig1C4UqMeIdmApNrb+hmIDOS/YAFLfYZpbFoH/4LEooN+9aNKk3j0i9Lz5PQk0cHwKvwm9haB7kEErVnDvWfZJBCvBK/ourymG3hoJyonIaPh6W+2hNGnV0EIP6po7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjOk4seMZZwoGNJH0/Ojbrpzk3ewpvN5Zr8aQfd8dLM=;
 b=1tH3BhsPOMTKCJEVOGd707isRYGVybD8v0nt7VObBY0YWozH6UnqxihEM1f5itLfNMslOGamGnPqSVbXDF1vuduCLCPCuyRqr4U8mPFp9p2ZvvHhUwVQHYqa87h/uFCb75mWeRFruIUavaANN/JmHLCNA4XMLEMEutip2xKtsVI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 03:39:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.025; Thu, 6 May 2021
 03:39:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] radeon, amdgpu drm-fixes-5.13
Date: Wed,  5 May 2021 23:39:29 -0400
Message-Id: <20210506033929.3875-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend
 Transport; Thu, 6 May 2021 03:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3c8dabb-a50c-4cf5-5d43-08d910409860
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3853AC8B023ED4B8A1BDC191F7589@MN2PR12MB3853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvjRolAK3CUYvcav94oulygyp9Mdo8CFnorK7RYU0mdmHYdBjwYJ1iuR2QiomVzWm9IYkYBQsrlc2hRfht8YequD75TaRFn0dhYwQTCa9S0Yk/NT8cIkE9NdJaElNE2CoE5b9I3Jn0kG6y03lgDMsdd8NIk9/P7zA5yS227uie4irQ/GZwZ6zLLQ0fV2X5nGf5goEYYcMtmNbPSJUAFBkvPLAcyKy1gAXFISjvMTO8nrH1iqXnmo5j1ZCb1FinHbvu90CZM0KQL2YA1TEOcHW8d7gzkF2OWYBmf+FuxdT8GAghKGn/p8ICFU6hK8/qT1s8CL0gv/Pqxnz1dK173csMGHm58WnxmrDktXa2hwcScgOeP/f7R4WJB9CF3vDSJvqiNVZvzELtfEldQ5EYcxoGtAUZHQtlaLtyR0CNc8JAmq63vOp/XmvKE5nunaWAtGQCu+3PzMK3v/SvEHi9cYtpjM/rDWyzWNK4SCDpvWNnMeqbpco9Ul6FgxhnENHslh39KtIqseXpnrua2iEQ2U+kx2/Z+pPC3wNuLRMQeHAvWE5Mrxxr07NyUShV+Qgj7g6J3znGtGgGOdmMxRG7VPakt9SrEjfSfpubVH46GS5FutxIUZOOwsWxAbJga3s8Q/QT/7n/hfXS0JWrI/rZWs3xNwHFIN4+fx6hxJ2G/mpIRnR10ydkrU8eunb9sgq8VzXrY9Q84JVjHBwW6tQi60qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(956004)(6506007)(1076003)(66574015)(5660300002)(66946007)(2616005)(16526019)(86362001)(186003)(8676002)(83380400001)(316002)(36756003)(52116002)(8936002)(478600001)(38100700002)(38350700002)(6666004)(4326008)(6512007)(966005)(66476007)(2906002)(66556008)(6486002)(26005)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2xFcUtLS0FqczFVWHg0YlgwNDhhZ3p5RU92TU5BOS9ONGh3U0RFcTh1aWVr?=
 =?utf-8?B?RDRIWlJOUkhIZ2hMT3Qrd2ZacFp3SFVHZEMzdEFOZnRkbkZ3cmRNQ2pTL3o3?=
 =?utf-8?B?bTh4UHRjM3lHTTZSdW9VUy8rcUV1bEtJd21UWDNzNzhLb3o5ZzcvdDM2UEVN?=
 =?utf-8?B?elRZank0TW01NVc5SDAySWhhck9JZnU1VXFSVFczT2QwTkpnSkUrRFpYUnph?=
 =?utf-8?B?cVRpQ3hwQUY1SzVYL2FFaTlPS3NuVVFEVUNTUGF3bDFCS3JyVkpiaUhSWlB1?=
 =?utf-8?B?b2dkVE9UeDdBWDlER3ZjSEtiN20wSWFsNTVMdmt6VG9OaEVBQ2VkMzF2SVU0?=
 =?utf-8?B?ZUJ5M3JhVy9wclY3N29XenlmbTI2YVUzRkE4RlRlMWsyanp6U1NaT0xLYjJ4?=
 =?utf-8?B?cUpscnpzNVN1Mml4MFlja3VvNEdSd05ycnlpcVd0TWI3Ujk2OW5YRFV6N044?=
 =?utf-8?B?Q0k0YXYxOFM5U1dQUzRIT2tJMzZ5SHZITUhlV1RleFVsY2xSNlN0N0dkb01M?=
 =?utf-8?B?NlErWldsUkdpK0ZSM1l4bTNHTm9EVGpuV2loakwxRXA5anpkazQ4akFiWEdT?=
 =?utf-8?B?UXNLWXFCOG1tenlHR3Yvd05MUStUelVsK2dvU0Q5UXBmS280byt3VGJMUXRj?=
 =?utf-8?B?V2RkSlozNVg3cEZoZFVhYXlYbnY4MmlLVXZDSmNOMVdHVWtxWEplRWlka20x?=
 =?utf-8?B?eVBzbklJM3pJMmFtekFnMjFJSEttMk9LMlp5bWZJM3FweCtHcnJqTVpqVURy?=
 =?utf-8?B?d1pMc3lUQWdFN3pGa3MzZG5Zek43SXBlOWEwai8xQm5yYjQ3MElEWDRTeEoy?=
 =?utf-8?B?K0Zjb1VyeUpveGVDY29McERhUVR0K0M1UFVLWS9vUWtWaE9lUFA0TzRpZHgw?=
 =?utf-8?B?eUs0cHNlQlVXU2NPeHFocUpvTWpBdG44QVVpWXhHeGVrc3BVYUFVb3haK2tF?=
 =?utf-8?B?YVdTeTMvdVc0ZDRza0s4TmthYWZUQlpKbWpjNHV3a0JPMTg5enV3MmJRZ0px?=
 =?utf-8?B?QWVjRVV0cXhJbmExWnk2WldGNnVGQzV4ckJoRGdZMXppa3R1NjNHQTJmZ1J2?=
 =?utf-8?B?TDYvYkJIc3llTkc4dThkWGtMTmFjcWZWUVZnV1JvcXU3aVQxc1dOYmdEUitl?=
 =?utf-8?B?cVpVaS9lQlVNOTNWRGh2TXg3Unl1N05NVDVwWlEvcGM3K2V0NXUrLy9IRWxO?=
 =?utf-8?B?aUoxNHVUQjdPTk9HdUg5L3ZyZEtUVUJvN29DZlo0VlZFR2gzTk12cVdrZ0ZC?=
 =?utf-8?B?SzI0T1FaNHZ2VXIzME10OXBwYTdkbVVtYjJCcFZpa0cveXE1bS8yaU82SEs3?=
 =?utf-8?B?VlBHN3plaXpCT3BZWlNqTnBqdWkvODdQZEVIdXJMWFF6ZC9BeDhpYXRvSmpm?=
 =?utf-8?B?Mjg2UElEM2FDaFk5UzcvWmVhV01yUnVjbkJDS1VCWEZqRW9aNzZ5aXRLblAy?=
 =?utf-8?B?dnkvaUVBSXpnb0MwRlZmQUdQZVNOQ2xPd01Fck1uWENoQ3VnNFB2SUhuNFE3?=
 =?utf-8?B?QlM1Nlo4amZWdXQwd1h4U1BDOGF6LzZ6a3JpejdGa0RRWnpBQ21IZVJScS9M?=
 =?utf-8?B?T0xjNXp4UWlTelgrUWVaYzdTSGZYdlptNlVvOTdpT1l3Mm5SUUIzeFZjT1JL?=
 =?utf-8?B?WXUxNEd0bDFPTkdzczRDc3UxTTVpekx6bE9Fck5jdDJlRVhUM1M5WXQvRE5Y?=
 =?utf-8?B?b3pTSjB6ZmNiSXR6c1FBbEI4UWZNRmFnTForOTRyN3E1VS9rekZGeWJFRmxx?=
 =?utf-8?Q?l7/4VXI5M5MyTT/3YIV7Hl7j3djcFWWkZ/s68wm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c8dabb-a50c-4cf5-5d43-08d910409860
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:39:47.2707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSvnp/LOX+BmlCI5IZhqyHly0FYILGcNem6bMES5V8+fwq+/2WMgicSzdztIrQcgUP9Em7xKGc4MaZ8MQlHs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRGF2ZSwgRGFuaWVsLAoKRml4ZXMgZm9yIDUuMTMuCgpUaGUgZm9sbG93aW5nIGNoYW5nZXMg
c2luY2UgY29tbWl0IGExYTFjYTcwZGViM2VjNjAwZWVhYmIyMWRlN2YzZjQ4YWFhZTU2OTU6Cgog
IE1lcmdlIHRhZyAnZHJtLW1pc2MtbmV4dC1maXhlcy0yMDIxLTA0LTIyJyBvZiBnaXQ6Ly9hbm9u
Z2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0vZHJtLW1pc2MgaW50byBkcm0tbmV4dCAoMjAyMS0wNC0y
MyAxMzo1MzowNyArMTAwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
OgoKICBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYWdkNWYvbGludXguZ2l0IHRhZ3Mv
YW1kLWRybS1maXhlcy01LjEzLTIwMjEtMDUtMDUKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byAyMzQwNTVmZDk3MjhlNjcyNjc4N2JjNjNiMjRiNjQ1MDAzNDg3NmNmOgoKICBkcm0vYW1k
Z3B1OiBVc2UgZGV2aWNlIHNwZWNpZmljIEJPIHNpemUgJiBzdHJpZGUgY2hlY2suICgyMDIxLTA1
LTA1IDIzOjA5OjU0IC0wNDAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQphbWQtZHJtLWZpeGVzLTUuMTMtMjAyMS0wNS0w
NToKCmFtZGdwdToKLSBNUE8gaGFuZyB3b3JrYXJvdW5kCi0gRml4IGZvciBjb25jdXJyZW50IFZN
IGZsdXNoZXMgb24gdmVnYS9uYXZpCi0gZGNlZmNsayBpcyBub3QgYWRqdXN0YWJsZSBvbiBuYXZp
MXggYW5kIG5ld2VyCi0gTVNUIEhQRCBkZWJ1Z2ZzIGZpeAotIFN1c3BlbmQvcmVzdW1lcyBmaXhl
cwotIFJlZ2lzdGVyIFZHQSBjbGllbnRzIGxhdGUgaW4gY2FzZSBkcml2ZXIgZmFpbHMgdG8gbG9h
ZAotIEZpeCBHRU0gbGVhayBpbiB1c2VyIGZyYW1lYnVmZmVyIGNyZWF0ZQotIEFkZCBzdXBwb3J0
IGZvciBwb2xhcmlzMTIgd2l0aCAzMiBiaXQgbWVtb3J5IGludGVyZmFjZQotIEZpeCBkdXBsaWNh
dGUgY3Vyc29yIGlzc3VlIHdoZW4gdXNpbmcgb3ZlcmxheQotIEZpeCBjb3JydXB0aW9uIHdpdGgg
dGlsZWQgc3VyZmFjZXMgb24gVkNOMwotIEFkZCBCTyBzaXplIGFuZCBzdHJpZGUgY2hlY2sgdG8g
Zml4IEJPIHNpemUgdmVyaWZpY2F0aW9uCgpyYWRlb246Ci0gRml4IG9mZi1ieS1vbmUgaW4gcG93
ZXIgc3RhdGUgcGFyc2luZwotIEZpeCBwb3NzaWJsZSBtZW1vcnkgbGVhayBpbiBwb3dlciBzdGF0
ZSBwYXJzaW5nCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkJhcyBOaWV1d2VuaHVpemVuICgyKToKICAgICAgZHJtL2FtZGdw
dTogSW5pdCBHRlgxMF9BRERSX0NPTkZJRyBmb3IgVkNOIHYzIGluIERQRyBtb2RlLgogICAgICBk
cm0vYW1kZ3B1OiBVc2UgZGV2aWNlIHNwZWNpZmljIEJPIHNpemUgJiBzdHJpZGUgY2hlY2suCgpD
aHJpc3RpYW4gS8O2bmlnICgxKToKICAgICAgZHJtL2FtZGdwdTogZml4IGNvbmN1cnJlbnQgVk0g
Zmx1c2hlcyBvbiBWZWdhL05hdmkgdjIKCkRhcnJlbiBQb3dlbGwgKDIpOgogICAgICBhbWRncHUv
cG06IFByZXZlbnQgZm9yY2Ugb2YgRENFRkNMSyBvbiBOQVZJMTAgYW5kIFNJRU5OQV9DSUNITElE
CiAgICAgIGFtZGdwdS9wbTogc2V0IHBwX2RwbV9kY2VmY2xrIHRvIHJlYWRvbmx5IG9uIE5BVkkx
MCBhbmQgbmV3ZXIgZ3B1cwoKRXZhbiBRdWFuICgxKToKICAgICAgZHJtL2FtZGdwdTogYWRkIG5l
dyBNQyBmaXJtd2FyZSBmb3IgUG9sYXJpczEyIDMyYml0IEFTSUMKCkhhcnJ5IFdlbnRsYW5kICgx
KToKICAgICAgZHJtL2FtZC9kaXNwbGF5OiBSZWplY3Qgbm9uLXplcm8gc3JjX3kgYW5kIHNyY194
IGZvciB2aWRlbyBwbGFuZXMKCkthaS1IZW5nIEZlbmcgKDEpOgogICAgICBkcm0vYW1kZ3B1OiBS
ZWdpc3RlciBWR0EgY2xpZW50cyBhZnRlciBpbml0IGNhbiBubyBsb25nZXIgZmFpbAoKS2VlcyBD
b29rICgyKToKICAgICAgZHJtL3JhZGVvbjogRml4IG9mZi1ieS1vbmUgcG93ZXJfc3RhdGUgaW5k
ZXggaGVhcCBvdmVyd3JpdGUKICAgICAgZHJtL3JhZGVvbjogQXZvaWQgcG93ZXIgdGFibGUgcGFy
c2luZyBtZW1vcnkgbGVha3MKCk1pa2l0YSBMaXBza2kgKDEpOgogICAgICBkcm0vYW1kL2Rpc3Bs
YXk6IGZpeCB3cm9uZyBzdGF0ZW1lbnQgaW4gbXN0IGhwZCBkZWJ1Z2ZzCgpQYXZhbiBLdW1hciBS
YW1heWFuYW0gKDEpOgogICAgICBkcm0vYW1kZ3B1OiBIYW5kbGluZyBvZiBhbWRncHVfZGV2aWNl
X3Jlc3VtZSByZXR1cm4gdmFsdWUgZm9yIGdyYWNlZnVsIHRlYXJkb3duCgpSb2RyaWdvIFNpcXVl
aXJhICgxKToKICAgICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggdHdvIGN1cnNvciBkdXBsaWNhdGlv
biB3aGVuIHVzaW5nIG92ZXJsYXkKClNpbW9uIFNlciAoMSk6CiAgICAgIGFtZGdwdTogZml4IEdF
TSBvYmogbGVhayBpbiBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZQoKVG9t
IFJpeCAoMSk6CiAgICAgIGRybS9hbWQvcG06IGluaXRpYWxpemUgdmFyaWFibGUKClZpY3RvciBa
aGFvICgxKToKICAgICAgZHJtL2FtZGdwdTogZml4IHIgaW5pdGlhbCB2YWx1ZXMKCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgICAgICAgICB8ICAyOCArKy0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jICAgICAgICB8IDE4NCAr
KysrKysrKysrKysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYyAgICAgICAgICAgIHwgICAzICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pZHMuYyAgICAgICAgICAgIHwgIDE5ICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgICAgICAgICAgICAgfCAgIDYgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmggICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y4XzAuYyAgICAgICAgICAgICAgfCAgMTMgKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92M18wLmMgICAgICAgICAgICAgIHwgICA0ICsKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgIHwgIDY4ICsrKysrKysrCiAuLi4v
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jICB8ICAgMiArLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyAgICAgICAgICAgICAgICAgfCAgMTAg
Ky0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jICAgIHwg
ICA1ICstCiAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYyAg
ICB8ICAgNCArLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyAgICAg
ICAgICAgfCAgMjYgKystCiAxNCBmaWxlcyBjaGFuZ2VkLCAzMjggaW5zZXJ0aW9ucygrKSwgNDUg
ZGVsZXRpb25zKC0pCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
