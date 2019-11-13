Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA6C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61354206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61354206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD786EDE3;
	Wed, 13 Nov 2019 19:07:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31ECD6EDE3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 19:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjWQbouCumrwl/4XEPFnlU+h4m/dGmv2CcD7/PdsBOMdC7Ey4gagdnEfBg06ViF2m+PRIht46FChx5x/mHcIe0suaw93I6w0GE8M0KIEavEuRHGg6qBeAXQJDvGid3eP9Tv7SjY8B1BceAduUUN/al/qwDQ1TroRuDiY2877MmlYiPyPr2p61uS8Hx9JKBToSIOsQgzVI6B1GVqLmDmLcZ7gMoc//uTLUkX5eOAURpVvbf9asWgiHHmcLT9lmSNFp0wiEpRTH1k5wnOu6OqK9EKUDtmPyYLZM+bsWVfuvEWQaX8Qxu20JSSNHt2AJKJ9rQka/rUQvvzfgq6XEEcfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK7TyxDyQmsLNpzvKNn7WB7nrbrod6GdQvqizfzD/cs=;
 b=E+o3J62KTI0x+nOU3JbmLBN7j6F3kxKDnEyOQV7BBeR4MsEc17UJ/kxjQ8+1NvMcGIUyOGeTcEPB0g/8q9iRiLEDMPzyqnroZIOBz8Vhz86tMx3rNc8NNM5IAT9HuxJHrmR/Q+LgifKYnz/rP3erU3RsWzoi746T8xMSyO7MoscW6C5MNYRAEN+7Cazwa+o7+R8k5jZeA5Ye6m9pDErZi3SbPAQ94GIM2wK8zMaXen33M84o0/DpTOBdhZMaTmZqwZcIoxJpDSMUbb4FjqF30U6fEj4hFetScW1h3waGz4V6pCRvYzzRsHYHYuBOIb8olPV3IdA7QFcPnRKYZsm63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0066.namprd12.prod.outlook.com (2603:10b6:3:103::28)
 by BN6PR1201MB0194.namprd12.prod.outlook.com (2603:10b6:405:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Wed, 13 Nov
 2019 19:07:36 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by DM5PR12CA0066.outlook.office365.com
 (2603:10b6:3:103::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 19:07:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 19:07:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 13:07:35 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 13:07:34 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 13 Nov 2019 13:07:34 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/dsc: Use 32-bit integers for some DSC parameter
 calculations
Date: Wed, 13 Nov 2019 14:07:28 -0500
Message-ID: <20191113190728.26645-2-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113190728.26645-1-mikita.lipski@amd.com>
References: <20191113190728.26645-1-mikita.lipski@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(189003)(199004)(6916009)(478600001)(50466002)(4326008)(1076003)(336012)(2876002)(426003)(305945005)(2616005)(47776003)(186003)(48376002)(446003)(2906002)(53416004)(11346002)(26005)(76176011)(2351001)(7696005)(476003)(126002)(51416003)(486006)(70586007)(8936002)(36756003)(6666004)(86362001)(8676002)(81166006)(81156014)(54906003)(5660300002)(356004)(70206006)(316002)(50226002)(16586007)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0194; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45890be0-9bc3-4145-a127-08d7686cbea6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0194:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0194F7F1AED9C72AA5D0CB6BE4760@BN6PR1201MB0194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4IS9zQFSlM/EwbYtqCrXIWH7QlaLr7llvSW3OZxBD/FPz996TaE4/e+4pWmjouP/FUD4PASFOSDAE8NIHIdf2xgpvA6AAfwBOZ6LWrAhlWega/ogvgy+ZJbSh0q8FdjbX0TKd0vkaBid/VuMLU21EvooRXzvB+AkxQ62zGBtSbGNDzmwlaflTQsHvH3jYRaIiSzpg1f6YrC3cXvW3hlu3H6d3DJNzfpoNk03xZQS2hODDBf1hFXOVuk7cTKhEybsIOXZwPlU9tXTNx9Oh3WCgU+AYvpdtI0b7aIYgGKxZHjKuitjnARUFT2JYVPg2fyDhgbkdC0EaSl0Q8l+eBwkLdy0kHlncak+48bao9RwQEimloznFkntOspoyjh+Ko58aL4xztoX0dDqAkkaEHfEmGOAhlLPclDUdmMrsbCC7QMKS8jewu21vbK4vriCdexo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 19:07:35.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45890be0-9bc3-4145-a127-08d7686cbea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0194
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK7TyxDyQmsLNpzvKNn7WB7nrbrod6GdQvqizfzD/cs=;
 b=1d7rUTSV2E8ew2a5PoFGPkHkW0z+46kOP7Um43s4A+pSu/5NgLwBahyqkIpqqhnMB47bhNtYjF3ZIzCRhZRLXYVdWOQo4KgZSYaua7pb0Q7qGs/2sP0wcwy5slV+gqV2fMtblsDcfE8pT4W7v3vxQ45hkvPk3xVDwhWLBAb6B08=
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
Cc: alexander.deucher@amd.com, manasi.d.navare@intel.com,
 Mikita Lipski <mikita.lipski@amd.com>, harry.wentland@amd.com,
 nikola.cornij@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113190728.i-HYVK6IFZl3sWkv_s7SryUO_jjGWegEaef4ZfAJuic@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KVGhlcmUg
YXJlIGEgZmV3IERTQyBQUFMgcGFyYW1ldGVycywgc3VjaCBhcyBzY2FsZV9pbmNyZW1lbnRfaW50
ZXJ2YWwsIHRoYXQKY291bGQgb3ZlcmZsb3cgMTYtYml0IGludGVnZXIgaWYgbm9uLURTQy1zcGVj
LWNvbXBsaWFudCBjb25maWd1cmF0aW9uIHdhcwp1c2VkLiBUaGVyZSBpcyBhIGNoZWNrIGluIHRo
ZSBjb2RlIGFnYWluc3QgdGhhdCwgaG93ZXZlciAxNi1iaXQgaW50ZWdlciBpcwp1c2VkIHRvIHN0
b3JlIHRob3NlIHZhbHVlcywgd2hpY2ggaW52YWxpZGF0ZXMgdGhlIGNoZWNrLCBsZXR0aW5nIGlu
dmFsaWQKY29uZmlndXJhdGlvbnMgdGhyb3VnaC4KCltob3ddClVzZSAzMi1iaXQgaW50ZWdlcnMg
Zm9yIHRoZSBhZmZlY3RlZCBEU0MgUFBTIHBhcmFtZXRlcnMgY2FsY3VsYXRpb25zCgpTaWduZWQt
b2ZmLWJ5OiBOaWtvbGEgQ29ybmlqIDxuaWtvbGEuY29ybmlqQGFtZC5jb20+ClNpZ25lZC1vZmYt
Ynk6IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vZHJtX2RzYy5jIHwgMzEgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5j
CmluZGV4IDc5YzcxZTNmYzk3My4uNzRmMzUyN2Y1NjdkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2RzYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMKQEAgLTI5Nyw2
ICsyOTcsOSBAQCBpbnQgZHJtX2RzY19jb21wdXRlX3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9k
c2NfY29uZmlnICp2ZHNjX2NmZykKIAl1bnNpZ25lZCBsb25nIGZpbmFsX3NjYWxlID0gMDsKIAl1
bnNpZ25lZCBsb25nIHJic19taW4gPSAwOwogCXVuc2lnbmVkIGxvbmcgbWF4X29mZnNldCA9IDA7
CisJdTMyIG5mbF9icGdfb2Zmc2V0OworCXUzMiBuc2xfYnBnX29mZnNldDsKKwl1MzIgc2NhbGVf
aW5jcmVtZW50X2ludGVydmFsOwogCiAJaWYgKHZkc2NfY2ZnLT5uYXRpdmVfNDIwIHx8IHZkc2Nf
Y2ZnLT5uYXRpdmVfNDIyKSB7CiAJCS8qIE51bWJlciBvZiBncm91cHMgdXNlZCB0byBjb2RlIGVh
Y2ggbGluZSBvZiBhIHNsaWNlICovCkBAIC0zNjQsMjggKzM2NywzMiBAQCBpbnQgZHJtX2RzY19j
b21wdXRlX3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9kc2NfY29uZmlnICp2ZHNjX2NmZykKIAkJ
ICogaGVuY2Ugd2UgbXVsdGlwbHkgYnkgMl4xMSBmb3IgcHJlc2VydmluZyB0aGUKIAkJICogZnJh
Y3Rpb25hbCBwYXJ0CiAJCSAqLwotCQl2ZHNjX2NmZy0+bmZsX2JwZ19vZmZzZXQgPSBESVZfUk9V
TkRfVVAoKHZkc2NfY2ZnLT5maXJzdF9saW5lX2JwZ19vZmZzZXQgPDwgMTEpLAorCQluZmxfYnBn
X29mZnNldCA9IERJVl9ST1VORF9VUCgodmRzY19jZmctPmZpcnN0X2xpbmVfYnBnX29mZnNldCA8
PCAxMSksCiAJCQkJCQkJKHZkc2NfY2ZnLT5zbGljZV9oZWlnaHQgLSAxKSk7CiAJZWxzZQotCQl2
ZHNjX2NmZy0+bmZsX2JwZ19vZmZzZXQgPSAwOworCQluZmxfYnBnX29mZnNldCA9IDA7CiAKIAkv
KiAyXjE2IC0gMSAqLwotCWlmICh2ZHNjX2NmZy0+bmZsX2JwZ19vZmZzZXQgPiA2NTUzNSkgewor
CWlmIChuZmxfYnBnX29mZnNldCA+IDY1NTM1KSB7CiAJCURSTV9ERUJVR19LTVMoIk5mbEJwZ09m
ZnNldCBpcyB0b28gbGFyZ2UgZm9yIHRoaXMgc2xpY2UgaGVpZ2h0XG4iKTsKIAkJcmV0dXJuIC1F
UkFOR0U7CiAJfQogCisJdmRzY19jZmctPm5mbF9icGdfb2Zmc2V0ID0gKHUxNiluZmxfYnBnX29m
ZnNldDsKKwogCWlmICh2ZHNjX2NmZy0+c2xpY2VfaGVpZ2h0ID4gMikKLQkJdmRzY19jZmctPm5z
bF9icGdfb2Zmc2V0ID0gRElWX1JPVU5EX1VQKCh2ZHNjX2NmZy0+c2Vjb25kX2xpbmVfYnBnX29m
ZnNldCA8PCAxMSksCisJCW5zbF9icGdfb2Zmc2V0ID0gRElWX1JPVU5EX1VQKCh2ZHNjX2NmZy0+
c2Vjb25kX2xpbmVfYnBnX29mZnNldCA8PCAxMSksCiAJCQkJCQkJKHZkc2NfY2ZnLT5zbGljZV9o
ZWlnaHQgLSAxKSk7CiAJZWxzZQotCQl2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgPSAwOworCQlu
c2xfYnBnX29mZnNldCA9IDA7CiAKLQlpZiAodmRzY19jZmctPm5zbF9icGdfb2Zmc2V0ID4gNjU1
MzUpIHsKKwlpZiAobnNsX2JwZ19vZmZzZXQgPiA2NTUzNSkgewogCQlEUk1fREVCVUdfS01TKCJO
c2xCcGdPZmZzZXQgaXMgdG9vIGxhcmdlIGZvciB0aGlzIHNsaWNlIGhlaWdodFxuIik7CiAJCXJl
dHVybiAtRVJBTkdFOwogCX0KIAorCXZkc2NfY2ZnLT5uc2xfYnBnX29mZnNldCA9ICh1MTYpbnNs
X2JwZ19vZmZzZXQ7CisKIAkvKiBOdW1iZXIgb2YgZ3JvdXBzIHVzZWQgdG8gY29kZSB0aGUgZW50
aXJlIHNsaWNlICovCiAJZ3JvdXBzX3RvdGFsID0gZ3JvdXBzX3Blcl9saW5lICogdmRzY19jZmct
PnNsaWNlX2hlaWdodDsKIApAQCAtNDAyLDEwICs0MDksMTAgQEAgaW50IGRybV9kc2NfY29tcHV0
ZV9yY19wYXJhbWV0ZXJzKHN0cnVjdCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcpCiAJCSAqIGFz
IChOZmxCcGdPZmZzZXQgKyBTbGljZUJwZ09mZnNldCkgaGFzIDExIGJpdCBmcmFjdGlvbmFsIHZh
bHVlLAogCQkgKiB3ZSBuZWVkIGRpdmlkZSBieSAyXjExIGZyb20gcHN0RHNjQ2ZnIHZhbHVlcwog
CQkgKi8KLQkJdmRzY19jZmctPnNjYWxlX2luY3JlbWVudF9pbnRlcnZhbCA9CisJCXNjYWxlX2lu
Y3JlbWVudF9pbnRlcnZhbCA9CiAJCQkJKHZkc2NfY2ZnLT5maW5hbF9vZmZzZXQgKiAoMSA8PCAx
MSkpIC8KLQkJCQkoKHZkc2NfY2ZnLT5uZmxfYnBnX29mZnNldCArCi0JCQkJdmRzY19jZmctPm5z
bF9icGdfb2Zmc2V0ICsKKwkJCQkoKG5mbF9icGdfb2Zmc2V0ICsKKwkJCQluc2xfYnBnX29mZnNl
dCArCiAJCQkJdmRzY19jZmctPnNsaWNlX2JwZ19vZmZzZXQpICoKIAkJCQkoZmluYWxfc2NhbGUg
LSA5KSk7CiAJfSBlbHNlIHsKQEAgLTQxMywxNCArNDIwLDE2IEBAIGludCBkcm1fZHNjX2NvbXB1
dGVfcmNfcGFyYW1ldGVycyhzdHJ1Y3QgZHJtX2RzY19jb25maWcgKnZkc2NfY2ZnKQogCQkgKiBJ
ZiBmaW5hbFNjYWxlVmFsdWUgaXMgbGVzcyB0aGFuIG9yIGVxdWFsIHRvIDksIGEgdmFsdWUgb2Yg
MCBzaG91bGQKIAkJICogYmUgdXNlZCB0byBkaXNhYmxlIHRoZSBzY2FsZSBpbmNyZW1lbnQgYXQg
dGhlIGVuZCBvZiB0aGUgc2xpY2UKIAkJICovCi0JCXZkc2NfY2ZnLT5zY2FsZV9pbmNyZW1lbnRf
aW50ZXJ2YWwgPSAwOworCQlzY2FsZV9pbmNyZW1lbnRfaW50ZXJ2YWwgPSAwOwogCX0KIAotCWlm
ICh2ZHNjX2NmZy0+c2NhbGVfaW5jcmVtZW50X2ludGVydmFsID4gNjU1MzUpIHsKKwlpZiAoc2Nh
bGVfaW5jcmVtZW50X2ludGVydmFsID4gNjU1MzUpIHsKIAkJRFJNX0RFQlVHX0tNUygiU2NhbGVJ
bmNyZW1lbnRJbnRlcnZhbCBpcyBsYXJnZSBmb3Igc2xpY2UgaGVpZ2h0XG4iKTsKIAkJcmV0dXJu
IC1FUkFOR0U7CiAJfQogCisJdmRzY19jZmctPnNjYWxlX2luY3JlbWVudF9pbnRlcnZhbCA9ICh1
MTYpc2NhbGVfaW5jcmVtZW50X2ludGVydmFsOworCiAJLyoKIAkgKiBEU0Mgc3BlYyBtZW50aW9u
cyB0aGF0IGJpdHNfcGVyX3BpeGVsIHNwZWNpZmllcyB0aGUgdGFyZ2V0CiAJICogYml0cy9waXhl
bCAoYnBwKSByYXRlIHRoYXQgaXMgdXNlZCBieSB0aGUgZW5jb2RlciwKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
