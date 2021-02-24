Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4970764ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4970764ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2116EB69;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDA26EB65
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1pDebL1YPu87Hdrc6OlcdKl8z0CGnHzTPz/sOfNVTHCiUACwMWUPwFIsOPdiPSviPIgCfdSrm3xez8KjjPYRprwgYFwSAwCzn9CzB6GgVxiaLgk1B2TUDhcfk9svEjHNUmaVQMQfbd5WwZK1HsiiGlxGPIyUAqkBnaiAvNk0/K+blV5sekaHEnp0l0ZOkr+x1xs/eDIkgSUQa7gmJwl/ZvkO5WstK7UijZAE9Pfh81xyvWvaOivy6l9uejGziyL6V6AF6WkZAysMGG8+SeQB8Xm/4QTRTZE+yt6D4JYiDeo/4jwjX29BP7E0/YEKkoo+/ImME30vdHKfK3s4x2v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiD+a4knvCE31LeuwhCeCd8JZnaXM2pWdon87B6aHns=;
 b=Gw2z8Qdy/v1iamJfSOqnYTum1p4s4F9KX9jSN9bWdqwZeAmS9kOm1bMcXIhP1c9WcbMEGtaj8N8fhiEruhc++l8wxCMnb61rFnsyFkzhYC93kemoKedGdXuaAPA6AgR9GryCEAvhqRWDbYTV+jXEJn67e8dcpGUX4oHZ/lP2y636OqlXJrWCCr5ij9cK7qLACvNBHx65RGxqd5cR7VweNHzzLVnjJY8Sr6sgZb8AknIMKxKC7XAQzywzjnG3coDaI3ohlTChlwVEDAhxauJheG+EI4/o1lpfOToJ+fvOqBAbUH/tts6CHVum63vC/NhWpfD446c83rraI1qWwxHGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiD+a4knvCE31LeuwhCeCd8JZnaXM2pWdon87B6aHns=;
 b=xCna1+KztrElFtqioOfxQzJuld2OWA+sgQ89s8cZk3lC9pGphFtqyqd/NXBRjCHUHYlT+aMgERQOMYjORk9ProzFI2qdFQAKkh0upIFRAackIen+0VV7vGAA6b7G+Gnj9pJet+u8wdpACCPb3a9/Ob7VvbuOnwK99AWLsSGX7Ic=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 083/159] drm/amdgpu: switch to vega20 ih block for aldebaran
Date: Wed, 24 Feb 2021 17:17:43 -0500
Message-Id: <20210224221859.3068810-76-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab36647e-c2e8-4870-75e0-08d8d9125d8a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404692CC8A0AC9E1F18FFDB3F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk6c1aCdZF38AZAhnkJySyzUFMLrmtt7de5pEYFpzbgdxKyWraDTPGO3O8uRtmkKCo2sH1FhFN2ixM98uCWfbKIL2/2EAt5M56vsfWt2JZ37nRJuqMrzKhgX8atG/Vs4LUle9/GAZ2DDzoIPCvY5NAv5N2sXzkUUzYgOd27NC2NA2OOcA5gICCeDfPwjb0dQAOSxUvogx4HUpoJoIQ3sdjw/CIGDlqk0i8BCLvdwbV2hC+9ZjUhRzrgkmscu2AcwO7N8FX0hoQ3oawVOoTTlrVHjA6nv5+tAOXeMtU964RC02DLAp9z/q6AfF9TzPwrQrmQSLeAhG8c3FOrf5Mq/eKLRjWb9ZhdngiyI28F3dq6MYwa/lZOWNtxTMwlos/FKCXuw9+JN99s+48Nu++8XTs6yamxchrY1in10UvqJ/Rf85F5fgfgrA3gOjy4xthQnn8nJLE53NlL6lBjltRm30BxC/Yy0GrmpN/0elfBYY8B1gPThcLjr1+0PnG5tASuavonuIrh0EmbdvWGvUVQx1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnhXeGVyWmFsL2NCMmhHK2hKM2pDVUhJLzBHdTlydmtPZEdzMXJvSkIrU1dV?=
 =?utf-8?B?cGk2d1MyTmUwVHpnT29vVGNjdW5DV09WV010VE91QmFDcktndmRmQ0FNTmRL?=
 =?utf-8?B?T2o5SlNMdjBKTEQ1aXBJUTYwRndRWm4xNE1pSXBoWkpMdWNYblRpbURCR3M5?=
 =?utf-8?B?SWp4OUszN0k3SStjc0ZpZnJia0xlRzExbXRVRmg2NHlLZkJMbWo3ZVpDclZp?=
 =?utf-8?B?TU5KNzFaMEpaMjVTUDFwaWo4cURDZ0kxb1Bhb1UrZGwrVVNBKzR6blBkczF1?=
 =?utf-8?B?U01VSEp3ODRxOXpwMDk2WFhabENzTFlLYmlmMlc1TWVZV2tVUS9ReXExSHow?=
 =?utf-8?B?WUxCQWtLUHpqYm4xb2dMWWhMMzNFWXBxZlh5VDFuOE5RSVB5RFVrclpqdmZo?=
 =?utf-8?B?RGkrb1Z2QjBESlFZalJpUXBzaFdCVkx0N1Qxa214SmJ2SFpEZlFPMVBRUGhN?=
 =?utf-8?B?NVl6VmtNZTkxUXlMRi94dzRzY1VFOWVxRm8zMXQxdjlHUVNvQ2RSTm9pN0pi?=
 =?utf-8?B?TC9LSUNYZkoybTFBVERCUUxzUU53bVN2VkQrODZIM2M2M0dScmhhUWxocEhE?=
 =?utf-8?B?U3VzVmdVeTBlWHBZTGg1bjUwN2ZzSGNBblk4cHVhWFE3US9HenUya1hpT0xW?=
 =?utf-8?B?MlhNOHRHbVZvRzRLY3hLQXBzTFhRK3laL2s0TFRmTnE0NTdId0VNZ3V4RS9I?=
 =?utf-8?B?Q05qZlRWMmNKak1LS2lDaVpSd1ZzY3lGVk9ZNWFuSjdpZ2RaY0wyeFpyVGwv?=
 =?utf-8?B?MTFyZi9SQk9OVzVvM3d1ZmxIQm5EdFNqc093Y3B6RE9kUGUxWEFSaXZZSUJH?=
 =?utf-8?B?eTlwcGVVQjBhbDEyL1ZXL1drcm9WcDM4VUlienV5Z1NPUWNLaVdoVldpKzZ1?=
 =?utf-8?B?WjN6SVY1K1A3V2dZSlRMSEl0YjBuTHRyTGV0UTVOcG1vcDZ3emdKa0NPUndI?=
 =?utf-8?B?c0VKSnE3aTFCOURSNVBFMlVMemw4T1lBY2N4S3pFRStpRmloL0dvcXRHdWlk?=
 =?utf-8?B?cVZScWhKbkFSSzhGUEx0Y1VURjE0WTVRUzEzbWVEWVZ4czYzdmVYWGQyd1I5?=
 =?utf-8?B?MmhROVlWUXk2MDBldVlqRkNYbUFhclJEb2ppaEZZS0h3cXRnQ3UxNUZzQytt?=
 =?utf-8?B?cXVQUll1L293UzNOM04wOWNzMW5jQUI2bGthY1prUHZ4U0ZBa1p1ZWdCdytk?=
 =?utf-8?B?KzltTStrRVd0WTZQY0FwUGE4a01WVHFoSHFpZzBQQkVxZUlyYU9kTjg4dDVs?=
 =?utf-8?B?K295NG9SU1diQTAwL1JGWGhZc3JWWExEckYvTlJWaGptamdwNHlibHNsd0cz?=
 =?utf-8?B?SWlRbVNNRnN4QW9Gc1ZlQittUFpmenFsVEw0dHc0YVp0ZlUwaDZ0MnNWdXhx?=
 =?utf-8?B?R04zaWpVQ2paUUs3K2RTd3RNc1k0Y2tKNk9SVXRvbHJHU0pHNEpKbVhEczFy?=
 =?utf-8?B?WXFWaFdNYitCUG9uZDROTU01KzBFbkQzOE9LY1E0b1NES1EvTXRQcFV6NXV4?=
 =?utf-8?B?TTBSZjBEYTVKUXFVamFmanJWUHI1ZHVqeXFXc24xYWhPc2I1eWtWa05PNjhD?=
 =?utf-8?B?cXNzcHZxVHlHSTZDMTMvWUpxRGpNcURKMG5hSnBXeWFpRGw4TnZZTGMyZDVh?=
 =?utf-8?B?eVRGZU5jQTNESWVOTkdUSStKTllpVkdqeUY1eHpLRzcvMUd3NHJLYjdESURn?=
 =?utf-8?B?NU1lMXFCYTJGOC9hNXRNcWpheXVja2xwK0N5cEw3dE04dlduZjVNbmJpWTZx?=
 =?utf-8?Q?IgWfO0nKYNmei9wa76qOp2AcKpELkA2+9XO+IEc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab36647e-c2e8-4870-75e0-08d8d9125d8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:17.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNLKJFsdICp/gLiz7bJ/g38bBjJh5Am3eoJbZnvfiWfeeYkBnn4srkhW/J86YQQnPJG5qOZQgrVgypUMUX4ugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKcmVwbGFjZSB2ZWdh
MTAgaWggYmxvY2sgd2l0aCB2ZWdhMjAgaWggYmxvY2sgZm9yCmFsZGViYXJhbi4KClNpZ25lZC1v
ZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQWNrZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExp
IDxEZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFt
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDI3NTQwOGMxNzhmMC4uOGM5M2NmNDExZjY4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTgyMSw5ICs4MjEsOSBAQCBpbnQgc29jMTVf
c2V0X2lwX2Jsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJaWYgKGFtZGdwdV9z
cmlvdl92ZihhZGV2KSkgewogCQkJaWYgKGxpa2VseShhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUg
PT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkKIAkJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChh
ZGV2LCAmcHNwX3YxM18wX2lwX2Jsb2NrKTsKLQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRk
KGFkZXYsICZ2ZWdhMTBfaWhfaXBfYmxvY2spOworCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19h
ZGQoYWRldiwgJnZlZ2EyMF9paF9pcF9ibG9jayk7CiAJCX0gZWxzZSB7Ci0JCQlhbWRncHVfZGV2
aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmVnYTEwX2loX2lwX2Jsb2NrKTsKKwkJCWFtZGdwdV9k
ZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYsICZ2ZWdhMjBfaWhfaXBfYmxvY2spOwogCQkJaWYgKGxp
a2VseShhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkKIAkJ
CQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmcHNwX3YxM18wX2lwX2Jsb2NrKTsK
IAkJfQotLSAKMi4yOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
