Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A3C07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AC021D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EhncQz6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC021D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB45F6E933;
	Thu, 10 Sep 2020 13:47:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450806E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO/LJFy/T4lkI9pQvM+n5j2e5o5wgKq8Ldp92vXguV+Q7ENjL4rJHXM4PUP+wYhAN2L/gtW5O4hIx8w55Ks1rvKmWtxUqRae8iDOOdW/DafHQPN349qQzY6xunA+c7e2eOMA5SZIt4AQuYCSB2cVjnXnRmKNGcFh2kQi/qMwyS2XeiMqP3MORh9wC4p5HrV8qnsBhNgDN7IsXfbxUXRgXzksNsRvXds21wzXReSofpwW+TcsrbFtiuf5sGCH62yBMG4De+7blvlsseBxKpDUi/plnu2xiGWIW8aGR5sOraQQIkZY646l4ml86ImvIb2NaXr9LRD5qrrxWBzYpzQECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4kumfOLUiGOfgs4big7G5CloO7Hmu4wEdoJuxMp8rQ=;
 b=UZ/BbpHKgZRdsHVEf6dxi7C5Q+MH6iIlFOZ6zG9XHNc8evNGqcQprJNEDEc99xlDWnpVdHu5FzxweKIS21nVmTLvpkgxq9ViKFTrOu08dJ/ppWkCDapQ+l1FQs30gAYMuvGLJK0QVtsWwu7/tdzrh4mtJgcXHtSVTBer+GMwR1ihjYlyGosKWz9MVa7QpiwzvmtuwLp6uxBBQudzeriwVvHge+WfM2Nq0nfGSmZcM92gkwhQxaTL83zHdeRc+ZCy03WRbv+Up0mz+4pCwnJh6RI897gOimik0H2kcDEuyU03NiUqBln/eNg43crP6JXDIfxCgtWsmuNJwnKOHZkdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4kumfOLUiGOfgs4big7G5CloO7Hmu4wEdoJuxMp8rQ=;
 b=EhncQz6x+c528Zd/Qqh6fp5d2KOrFQEIrL/GEwfYvqWlLOupVibcvJEh+kf4iyN4kd5djCOnybyveZR8Q/QIk9shvJej3YSdB0eZYxnyID439HCwNMtVJMApFSSPjWeQEyUJ41wLeZWfmDS67bkl+NCg8SUEIGrPPvsOzjAhciw=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:27 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::1a) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:26 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/42] drm/amd/display: Detect plane change when detect pipe
 change.
Date: Thu, 10 Sep 2020 09:46:45 -0400
Message-ID: <20200910134723.27410-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6fcc1c-bbfb-4975-8bf2-08d855900e12
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:
X-Microsoft-Antispam-PRVS: <BY5PR12MB376282A70D179DC7A93C350E8B270@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 888bv6w5HjVypUkBXaBx3xUMAhShz7F/tBiP+1djCkEgidZs4ygVD+ZHs5m67lRxpw9BSO6QdhsbYUmULUmPYnZEXarZgA9f41jcV6sTgduW6Ry49lSd+78nIA7d5VEf+ic6QPCVEiZB7bq0CPO7e4oUjAtHIiNobf8Oxc5j5QkhNtzCPasN8jfGW3F+iylBElsJNw7cYFt0nmxn8S8+kYId+FlRR/CyHQP+NV57oy0crmFZVWXtHrwFVOeyi3Mqg1Xce7Q2+zkI3zRAw9uiOCA4FCWU4VMdSuH14YdAk7BvrQuAquQNBLCW/N02NNYPoR/0MIHccZQjrH4Kw9dXD9pGfbIOJ45RPXxP8zIaGn4eHFTfMwUrsTwxSTsrcnJc8V9yIpqYU5dqyjqG61JkPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(8936002)(7696005)(4326008)(6916009)(83380400001)(2906002)(54906003)(36756003)(86362001)(82740400003)(47076004)(2616005)(336012)(478600001)(44832011)(426003)(356005)(316002)(81166007)(82310400003)(70586007)(6666004)(26005)(5660300002)(8676002)(186003)(70206006)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:27.2243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6fcc1c-bbfb-4975-8bf2-08d855900e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogIkppblplLlh1IiA8SmluWmUuWHVAYW1kLmNvbT4KCltXaHldCklmIHBsYW5lIGhhcyBj
aGFuZ2VkLCBkY24yMF9kZXRlY3RfcGlwZV9jaGFuZ2VzIGRvZXNuJ3QgdXBkYXRlIGRjX3BsYW5l
X3N0YXRlLT51cGRhdGVfZmxhZ3MsIGFuZCB0aGUgZm9sbG93aW5nIGRjbjIwX3Byb2dyYW1fcGlw
ZSBjYW4ndCByZXByb2dyYW0gaHVicCBjb3JyZWN0bHkuCgpbSG93XQpBZGQgYSBuZXcgZmxhZ3Mg
Yml0ICJwbGFuZV9jaGFuZ2VkIiBpbiBwaXBlX2N0eC0+dXBkYXRlX2ZsYWdzLklmIG9sZCBwbGFu
ZSBpc27igJl0IGlkZW50aWNhbCB0byBuZXcgcGxhbmUsIHRoaXMgYml0IHdpbGwgYmUgc2V0IGFu
ZCBndWlkZSDigJxkY24yMF9wcm9ncmFtX3BpcGXigJ0gdG8gcHJvZ3JhbWluZyBIVUJQIGNvcnJl
Y3RseS4KClNpZ25lZC1vZmYtYnk6IEppblplLlh1IDxKaW5aZS5YdUBhbWQuY29tPgpBY2tlZC1i
eTogQXVyYWJpbmRvIFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jIHwgMTIgKysrKysr
KysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2NvcmVfdHlwZXMuaCAg
ICB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24y
MF9od3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3
c2VxLmMKaW5kZXggYzhjZmQzYmExYzE1Li5lZTMzNDg3MTFhYmUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCkBAIC0xMjUxLDYg
KzEyNTEsMTEgQEAgc3RhdGljIHZvaWQgZGNuMjBfZGV0ZWN0X3BpcGVfY2hhbmdlcyhzdHJ1Y3Qg
cGlwZV9jdHggKm9sZF9waXBlLCBzdHJ1Y3QgcGlwZV9jdHgKIAkJcmV0dXJuOwogCX0KIAorCS8q
IERldGVjdCBwbGFuZSBjaGFuZ2UgKi8KKwlpZiAob2xkX3BpcGUtPnBsYW5lX3N0YXRlICE9IG5l
d19waXBlLT5wbGFuZV9zdGF0ZSkgeworCQluZXdfcGlwZS0+dXBkYXRlX2ZsYWdzLmJpdHMucGxh
bmVfY2hhbmdlZCA9IHRydWU7CisJfQorCiAJLyogRGV0ZWN0IHRvcCBwaXBlIG9ubHkgY2hhbmdl
cyAqLwogCWlmICghbmV3X3BpcGUtPnRvcF9waXBlICYmICFuZXdfcGlwZS0+cHJldl9vZG1fcGlw
ZSkgewogCQkvKiBEZXRlY3Qgb2RtIGNoYW5nZXMgKi8KQEAgLTEzOTIsNiArMTM5Nyw3IEBAIHN0
YXRpYyB2b2lkIGRjbjIwX3VwZGF0ZV9kY2h1YnBfZHBwKAogCQkJJnBpcGVfY3R4LT50dHVfcmVn
cyk7CiAKIAlpZiAocGlwZV9jdHgtPnVwZGF0ZV9mbGFncy5iaXRzLmVuYWJsZSB8fAorCQkJcGlw
ZV9jdHgtPnVwZGF0ZV9mbGFncy5iaXRzLnBsYW5lX2NoYW5nZWQgfHwKIAkJCXBsYW5lX3N0YXRl
LT51cGRhdGVfZmxhZ3MuYml0cy5icHBfY2hhbmdlIHx8CiAJCQlwbGFuZV9zdGF0ZS0+dXBkYXRl
X2ZsYWdzLmJpdHMuaW5wdXRfY3NjX2NoYW5nZSB8fAogCQkJcGxhbmVfc3RhdGUtPnVwZGF0ZV9m
bGFncy5iaXRzLmNvbG9yX3NwYWNlX2NoYW5nZSB8fApAQCAtMTQxNCw2ICsxNDIwLDcgQEAgc3Rh
dGljIHZvaWQgZGNuMjBfdXBkYXRlX2RjaHVicF9kcHAoCiAJfQogCiAJaWYgKHBpcGVfY3R4LT51
cGRhdGVfZmxhZ3MuYml0cy5tcGNjCisJCQl8fCBwaXBlX2N0eC0+dXBkYXRlX2ZsYWdzLmJpdHMu
cGxhbmVfY2hhbmdlZAogCQkJfHwgcGxhbmVfc3RhdGUtPnVwZGF0ZV9mbGFncy5iaXRzLmdsb2Jh
bF9hbHBoYV9jaGFuZ2UKIAkJCXx8IHBsYW5lX3N0YXRlLT51cGRhdGVfZmxhZ3MuYml0cy5wZXJf
cGl4ZWxfYWxwaGFfY2hhbmdlKSB7CiAJCS8vIE1QQ0MgaW5zdCBpcyBlcXVhbCB0byBwaXBlIGlu
ZGV4IGluIHByYWN0aWNlCkBAIC0xNTE1LDYgKzE1MjIsNyBAQCBzdGF0aWMgdm9pZCBkY24yMF91
cGRhdGVfZGNodWJwX2RwcCgKIAl9CiAKIAlpZiAocGlwZV9jdHgtPnVwZGF0ZV9mbGFncy5iaXRz
LmVuYWJsZSB8fAorCQkJcGlwZV9jdHgtPnVwZGF0ZV9mbGFncy5iaXRzLnBsYW5lX2NoYW5nZWQg
fHwKIAkJCXBpcGVfY3R4LT51cGRhdGVfZmxhZ3MuYml0cy5vcHBfY2hhbmdlZCB8fAogCQkJcGxh
bmVfc3RhdGUtPnVwZGF0ZV9mbGFncy5iaXRzLnBpeGVsX2Zvcm1hdF9jaGFuZ2UgfHwKIAkJCXBs
YW5lX3N0YXRlLT51cGRhdGVfZmxhZ3MuYml0cy5ob3Jpem9udGFsX21pcnJvcl9jaGFuZ2UgfHwK
QEAgLTE1MzksNyArMTU0Nyw5IEBAIHN0YXRpYyB2b2lkIGRjbjIwX3VwZGF0ZV9kY2h1YnBfZHBw
KAogCQlodWJwLT5wb3dlcl9nYXRlZCA9IGZhbHNlOwogCX0KIAotCWlmIChwaXBlX2N0eC0+dXBk
YXRlX2ZsYWdzLmJpdHMuZW5hYmxlIHx8IHBsYW5lX3N0YXRlLT51cGRhdGVfZmxhZ3MuYml0cy5h
ZGRyX3VwZGF0ZSkKKwlpZiAocGlwZV9jdHgtPnVwZGF0ZV9mbGFncy5iaXRzLmVuYWJsZSB8fAor
CQlwaXBlX2N0eC0+dXBkYXRlX2ZsYWdzLmJpdHMucGxhbmVfY2hhbmdlZCB8fAorCQlwbGFuZV9z
dGF0ZS0+dXBkYXRlX2ZsYWdzLmJpdHMuYWRkcl91cGRhdGUpCiAJCWh3cy0+ZnVuY3MudXBkYXRl
X3BsYW5lX2FkZHIoZGMsIHBpcGVfY3R4KTsKIAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2NvcmVfdHlwZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9pbmMvY29yZV90eXBlcy5oCmluZGV4IDMyOTM5NWVlNzQ2MS4uY2M1ZjA1M2Vm
NWEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2NvcmVf
dHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2NvcmVfdHlw
ZXMuaApAQCAtMzAwLDYgKzMwMCw3IEBAIHVuaW9uIHBpcGVfdXBkYXRlX2ZsYWdzIHsKIAkJdWlu
dDMyX3QgZ2FtdXRfcmVtYXAgOiAxOwogCQl1aW50MzJfdCBzY2FsZXIgOiAxOwogCQl1aW50MzJf
dCB2aWV3cG9ydCA6IDE7CisJCXVpbnQzMl90IHBsYW5lX2NoYW5nZWQgOiAxOwogCX0gYml0czsK
IAl1aW50MzJfdCByYXc7CiB9OwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
