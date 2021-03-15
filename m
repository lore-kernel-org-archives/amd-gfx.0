Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36164E0C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE36164E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796C889E32;
	Mon, 15 Mar 2021 11:23:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589FB89E39
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLVpwibiXdjJngHaGurZB5NzGGSPOE6wmUvf/qd8bj8CrPxtEJWPmnxs1P0+Or+aLOvATzntaN0K32LcHQzxqY/tUddUq+mwt243Bc2skKWXkCgMTeO2QRk0W476gV0wvPXM0pEMA6TWMAQRFA503nMJdtiJ6qeN1AxZrDYa4RtywJ2u/GULqjBEXA4pXQPJKRIfuLIIjGUg5tMypoparnjLBc2NdmiL/D4d4m17/cBA430UmaYteQCiar5r24idPo27sRhmxCtslpmJtxpmXmEUubzhdMQI0WnwAzcna1LqInB4h8BcabChXE+lsyPrwGrtcWRHMdebJ/TELPuU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/64QE//CnuOfEPlSmEVdXHQOutcj/hfYn76uausukos=;
 b=Wnt4UXwgUNYxdcdusZXox+U21HiAr2hYtIw2VVNuX5rxBteH1Xkqy8Fmu8v6aPJiB1IVY0PKw+MIriqybLGDmIDxZ8CEVFzyqEmy9LpE7WIL32dfB5DuADl3DTmyZCFSXqC3Emv6BmARRUS3+qMOCxlRVzo6bukSqCkRFsctC6meDdgKSBAsRrMG2jl9quhHMLXt3/8AFtuMYfgiAOuKVInt7Z0a4JWFCZWP3YkkThIww+kgP77x8oFu7dlFgc29JClnZBmDCTtf5tjPuhVNwnsIprHGTzWXAgUua18tQ9a8ZGeCrC4YnRysyVpR0u1dHozWYgzFOhQzFlOkqzQZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/64QE//CnuOfEPlSmEVdXHQOutcj/hfYn76uausukos=;
 b=I8nASsIiUfEs4MZEOlPYnW+DbC4JL50592N7rWZ1mBWGN5XG1TMkmbFeqrsu/2B+qduLTLR+CWztzvhadW6df8n4RA+GDhkjw1NPxMCS8gWFqdt2fofgtpyP+GCH0LOxef00rNNXf8i8s9SFVqPlYRc8t0tC1gT6IXp6a1Hrv1Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:51 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:51 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/23] drm/amd/display: add a func to disable accelerated mode
Date: Mon, 15 Mar 2021 09:40:09 +0800
Message-Id: <20210315014010.16238-23-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc919eb6-a0c0-4912-3e86-08d8e7a4cf6e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB154854DB77E9FFA1A8C9BAAD976C9@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Zjx1PX0U7+31qaIfpZfiN2//vQqPOdO3KyVeDQ0sh0h4CqVOhm961shnPhD8G2Ubv1SzAomtmlCeVInoHBzK9eqcJrp61szNBEUnN4x+2OXQaUw8+mxoTGs6grM/18k5vXIOV3/WL6IVa/rVd40BYvcMdAm5EA3YmtguCSz05T8RrI7Cr+koU/6+hEywiWZMdTooF6QXruJmhaPs4JUwOKcXkRcyaboyheFblRF0eF1YV2OhrGYq4j/tLr1poGo44xsRmMzSP0lKVe3rNkLNrvWoygnK9xZnhvEVXcHETJpQ3tAfOPC3ar670x6zBQHKH2/0taH3CqlXeFM+5Mg2sj+FIswK0A323dO6OKqYgvk16ZkUXkJL214y8YAnhF3tMaH5yA8zerWq+alEzyQ93LONxa0oz00OSwuhWHRGPhEn4pLAybG7nNa3FTZSu6/aQZZ4Vt2qb2XpotiEs0Tlo/YdziToODlj5nA9qzgnIdRYemInK5zgsNbNTN6QraDB1VYKx9UmV3BfDpECmObYybLZar65m2YuX92IBuoP7tWmMftyEtof5pnpW6Jrr6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(316002)(956004)(44832011)(2616005)(54906003)(26005)(66946007)(2906002)(1076003)(66476007)(16526019)(186003)(6512007)(86362001)(6666004)(6486002)(8936002)(52116002)(8676002)(66556008)(6506007)(5660300002)(6916009)(4326008)(478600001)(36756003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RzhmMWo0SW1oRkhrY25IYnVXNk1TY2VOQU9mdlBtc3p1clJlUmQ1TFNCWmZQ?=
 =?utf-8?B?cy9TSEcxejk3YWhJYjRPYkRKZ3RDakc0Y0h2NytMOWV2SG9sa013b21iUTJ5?=
 =?utf-8?B?RlVrVUI2RkxzRXNzdGxMYTU0TktCRXpEMVJuNys1T0tjYWxNYXNPS2ZVV2tE?=
 =?utf-8?B?N0lDVm42cGpZR1UxTlhKc0VmTEFIM2s2cWhaZWJTalYvYmVFVU5lQ1Zyblhq?=
 =?utf-8?B?RDZjWFdWYzB2N1h6TkR1MFZIb3BCaGNiY1pCRytXcGxGdi95bzEzbmhXaWlB?=
 =?utf-8?B?TkZrOEtsYzZEckhQL2ZrdDBBdUZBL3Q1UnJaTXZ2TmRxM2pLSGRsNmZ3WUFY?=
 =?utf-8?B?SjJCdVdsVlJLMitXeWZNS0dIS1hxZmRTeEV3NDV5aGgzVzNEVHdYSmxjczdS?=
 =?utf-8?B?a2Y5R0h6QTM5NTQvSEJ2RHJhcmMwNDhSc0VERm9YTFZ5VWZMMWtINWFnNHBp?=
 =?utf-8?B?NHRLSlRuand2ZXN2NzZKMjdiZXhhOWdvRWNHdkZuVmg3VFVWVHI1Vjl2dG8y?=
 =?utf-8?B?ak1hQkFNTzdxdlJRckxBSG42aXF5d0lFeit4eGp5QkVRVW54aitWL1c4T0Mr?=
 =?utf-8?B?SDBoUWdKVklPSUJnTlNMZnFrRHB6dW9kR1JSa0I5ajAzMW9vamY1Vm9XbDRK?=
 =?utf-8?B?YktDOUFaL2ZYK1hPcnZkOU1LNncvek1tVXlJZHd0TFVRTVpEUGdEQWhEQWY1?=
 =?utf-8?B?THp6Ykd6TWlZcHVkMjFEYVRSa3RLdlBqZ3pyRDZaOVI3ZVM3a29YeCt2dlhu?=
 =?utf-8?B?dmF5ZVc1MzdFUWdJYU9KNWY0Qng0cllWVVlIODJJYzlCSFNoMEFCQXpOZ3di?=
 =?utf-8?B?WHZUaWVPVDQ3N0QvZGdIQklzSE9aclg3cjQ3UUQ0NUxRZ21FNEVaMS9sWVFk?=
 =?utf-8?B?eHFPMTBHN2ZvK3Y2b3hicUhOKy9jWVZObDNVVUZWWVV6OHFIVEJWRU8xSHlD?=
 =?utf-8?B?eGd6cDVnOG5jcWo2SEtBay9JT2VqSyswWk1JbzZEcGtFYkw2cXFiTVM2bVVl?=
 =?utf-8?B?eFdCU01tN1p6RDhjT0NJOEk2eU9JZzNSaFREWW16T0xnK1RjQ3c2dzRheEZy?=
 =?utf-8?B?c3h4QTJDWnZYY1oxTWlZbDVZTlVOMGtidmJ4c0FUcnloY0U2aXkrNllRU3Fo?=
 =?utf-8?B?YTRKaUIvVS9IWTlTNC96VW1MQW1INktsSjZyNHMyQ2JEQ095UFMxaE54OWpz?=
 =?utf-8?B?UlJHV09sNVNjeUpjY1c4NzBXWnZCNmlNeDBpV2MzcEF6TlNiNUJWdnBFMnZY?=
 =?utf-8?B?Y05QaXd0anFxVkpvaG9CNnBkYmJXTDN0K2t0ajlxbCtMZWhnS3FNZXVvUjEz?=
 =?utf-8?B?KytqSlQ4Y1FBcndKVGtiSWZkNVUrN3lXUU5NN2RlbUhaZllwMDBGbW1oNm5x?=
 =?utf-8?B?bnNlWkcxQmM1ME1lUHl5Q2lFem9UeFNBQUNQR25pNFl2QnBnV1l2TWN4YmQy?=
 =?utf-8?B?UitiK0M5SFdScnpnWU1xQTVrdStnclZkMUROUC9hUllxR2JhMWh6bS9vVEY5?=
 =?utf-8?B?STAvKzc3SXQ1YmV6SWFuNVd0UG14OGg5S1ZubU9zMTB5ai82Zy9aaGM0S3Ey?=
 =?utf-8?B?QnB2Y3VGcWhiQ0Z3eGFoclEzRUZ5bmM2Mkh0cUxiZTUyNzNaUGNEdFNzemtu?=
 =?utf-8?B?UTZUV2gxSFFRcHZrV3BkN3JSN2tPandsV1BqNjI5OE90TGUrYTlPbS8xMEYy?=
 =?utf-8?B?K20vUno1R3V0WStZNTRJK2I1bE1kRWsyVm1wRWUxa1lIUmZnNWRiOVdhb2hP?=
 =?utf-8?B?ZUtvVEpWYUk3bFBYMDVFZHduZnlua0ZzSkpJUjhsY29yTWxTRGh1ZUhOTkRU?=
 =?utf-8?B?MW8xdGJuRWhZNmNwcFV1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc919eb6-a0c0-4912-3e86-08d8e7a4cf6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:51.5665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WW7LSjX+LgU+VN+EsLrWb9gUejx2fn8NFF0F9QJcSVzRSPL7cyrkMVGg+cru0aVCaqQXuuQa36C+9ccnMdUpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Yao Wang1 <Yao.Wang1@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogWWFvIFdhbmcxIDxZYW8uV2FuZzFAYW1kLmNvbT4KCltXaHldCldoZW4gZHJpdmVyIGRp
c2FibGVkLCB3ZSBkcml2ZXIgZm9yY2UgdGhlIFlDYkNyNDIwIHRvIFJHQiwKd2hpY2ggbWVhbnMg
c29tZSByZWdpc3RlciB3aWxsIGJlIGNoYW5nZWQsIHN1Y2ggYXMKUkRQQ1NfUEhZX0RQX01QTExC
X1RYX0NMS19ESVYgY2hhbmdlZCBmcm9tIDEgdG8gMApXaGVuIGRyaXZlciByZS1lbmFibGVkLCBP
UyB3aWxsIFNldCBNb2RlIFlDYkNyNDIwIGFnYWluLAp3aGljaCBtZWFucyB0aGUgcmVnaXN0ZXIg
UkRQQ1NfUEhZX0RQX01QTExCX1RYX0NMS19ESVYKc2hvdWxkIHRvIGJlIDEgYWdhaW4sIGJ1dCBk
bXViIGZ3IGNhbuKAmXQgdXBkYXRlIHRoZQpyZWdpc3RlciB0byAxIGR1ZSB0byB0aGUgbXBsbCBp
cyBub3Qgb2ZmCgpbSG93XQpBZGRzIGFuIGludGVyZmFjZSB0byBkaXNhYmxlIGFjY2VsZXJhdGVk
IG1vZGUgYml0LAp3aGljaCBhbGxvd3MgRE0gdG8gZGVjaWRlIHRvIGNhbGwgZHVyaW5nIGRyaXZl
cgpkaXNhYmxlL3VubG9hZCBzY2VuYXJpb3MuCgpTaWduZWQtb2ZmLWJ5OiBZYW8gV2FuZzEgPFlh
by5XYW5nMUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFt
ZC5jb20+CkFja2VkLWJ5OiBTb2xvbW9uIENoaXUgPHNvbG9tb24uY2hpdUBhbWQuY29tPgotLS0K
IC4uLi9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyX2hlbHBlci5jICAgfCAgNSArKyst
LQogLi4uL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXJfaGVscGVyLmggICB8ICAyICst
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jICAgICAgIHwgMTggKysr
KysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAg
ICAgICAgIHwgIDYgKysrKysrCiAuLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jICAgIHwgIDIgKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Ymlvcy9iaW9zX3BhcnNlcl9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2Jpb3NfcGFyc2VyX2hlbHBlci5jCmluZGV4IGZjZTQ2YWI1NGM1NC4uNTNkNzUxM2I1
MDgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9z
X3BhcnNlcl9oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlv
cy9iaW9zX3BhcnNlcl9oZWxwZXIuYwpAQCAtNjQsOSArNjQsMTAgQEAgYm9vbCBiaW9zX2lzX2Fj
Y2VsZXJhdGVkX21vZGUoCiAKIAogdm9pZCBiaW9zX3NldF9zY3JhdGNoX2FjY19tb2RlX2NoYW5n
ZSgKLQlzdHJ1Y3QgZGNfYmlvcyAqYmlvcykKKwlzdHJ1Y3QgZGNfYmlvcyAqYmlvcywKKwl1aW50
MzJfdCBzdGF0ZSkKIHsKLQlSRUdfVVBEQVRFKEJJT1NfU0NSQVRDSF82LCBTNl9BQ0NfTU9ERSwg
MSk7CisJUkVHX1VQREFURShCSU9TX1NDUkFUQ0hfNiwgUzZfQUNDX01PREUsIHN0YXRlKTsKIH0K
IAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9z
X3BhcnNlcl9oZWxwZXIuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jp
b3NfcGFyc2VyX2hlbHBlci5oCmluZGV4IDc1YTI5ZTY4ZmIyNy4uZTFiNGE0MGEzNTNkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcl9o
ZWxwZXIuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3Bh
cnNlcl9oZWxwZXIuaApAQCAtMzIsNyArMzIsNyBAQCB1aW50OF90ICpiaW9zX2dldF9pbWFnZShz
dHJ1Y3QgZGNfYmlvcyAqYnAsIHVpbnQzMl90IG9mZnNldCwKIAl1aW50MzJfdCBzaXplKTsKIAog
Ym9vbCBiaW9zX2lzX2FjY2VsZXJhdGVkX21vZGUoc3RydWN0IGRjX2Jpb3MgKmJpb3MpOwotdm9p
ZCBiaW9zX3NldF9zY3JhdGNoX2FjY19tb2RlX2NoYW5nZShzdHJ1Y3QgZGNfYmlvcyAqYmlvcyk7
Cit2b2lkIGJpb3Nfc2V0X3NjcmF0Y2hfYWNjX21vZGVfY2hhbmdlKHN0cnVjdCBkY19iaW9zICpi
aW9zLCB1aW50MzJfdCBzdGF0ZSk7CiB2b2lkIGJpb3Nfc2V0X3NjcmF0Y2hfY3JpdGljYWxfc3Rh
dGUoc3RydWN0IGRjX2Jpb3MgKmJpb3MsIGJvb2wgc3RhdGUpOwogdWludDMyX3QgYmlvc19nZXRf
dmdhX2VuYWJsZWRfZGlzcGxheXMoc3RydWN0IGRjX2Jpb3MgKmJpb3MpOwogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwppbmRleCBkZmZkMTUwMTgwZWMuLjhlNmM4MTVi
NTVkMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC00MSw2
ICs0MSw3IEBACiAjaW5jbHVkZSAiZGNfYmlvc190eXBlcy5oIgogCiAjaW5jbHVkZSAiYmlvc19w
YXJzZXJfaW50ZXJmYWNlLmgiCisjaW5jbHVkZSAiYmlvcy9iaW9zX3BhcnNlcl9oZWxwZXIuaCIK
ICNpbmNsdWRlICJpbmNsdWRlL2lycV9zZXJ2aWNlX2ludGVyZmFjZS5oIgogI2luY2x1ZGUgInRy
YW5zZm9ybS5oIgogI2luY2x1ZGUgImRtY3UuaCIKQEAgLTMzNzIsMyArMzM3MywyMCBAQCBib29s
IGRjX3Byb2Nlc3NfZG11Yl9hdXhfdHJhbnNmZXJfYXN5bmMoc3RydWN0IGRjICpkYywKIAogCXJl
dHVybiB0cnVlOwogfQorCisvKioKKyAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICogIEZ1bmN0aW9u
OiBkY19kaXNhYmxlX2FjY2VsZXJhdGVkX21vZGUKKyAqCisgKiAgQGJyaWVmCisgKgkJZGlzYWJs
ZSBhY2NlbGVyYXRlZCBtb2RlCisgKgorICogIEBwYXJhbQorICoJCVtpbl0gZGM6IGRjIHN0cnVj
dHVyZQorICoKKyAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICovCit2b2lkIGRjX2Rpc2FibGVfYWNj
ZWxlcmF0ZWRfbW9kZShzdHJ1Y3QgZGMgKmRjKQoreworCWJpb3Nfc2V0X3NjcmF0Y2hfYWNjX21v
ZGVfY2hhbmdlKGRjLT5jdHgtPmRjX2Jpb3MsIDApOworfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGMuaAppbmRleCAzNTI2NTFjODA1ZmYuLmQxNjMwMDdlMDU3YyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTEzMTMsNCArMTMxMywxMCBAQCBib29sIGRjX3Byb2Nlc3Nf
ZG11Yl9hdXhfdHJhbnNmZXJfYXN5bmMoc3RydWN0IGRjICpkYywKICAqIERTQyBJbnRlcmZhY2Vz
CiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqLwogI2luY2x1ZGUgImRjX2RzYy5oIgorCisvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKgorICogRGlzYWJsZSBhY2MgbW9kZSBJbnRlcmZhY2VzCisgKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqLwordm9pZCBkY19kaXNhYmxlX2FjY2VsZXJhdGVkX21vZGUoc3RydWN0
IGRjICpkYyk7CisKICNlbmRpZiAvKiBEQ19JTlRFUkZBQ0VfSF8gKi8KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVu
Y2VyLmMKaW5kZXggMDgwNDc4MDJkMDQwLi44MDQwOTJmODFmODUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jCkBAIC0xNzUwLDcgKzE3NTAsNyBAQCB2b2lkIGRjZTExMF9lbmFibGVfYWNjZWxlcmF0
ZWRfbW9kZShzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQpCiAJCWlmIChl
ZHBfbGlua193aXRoX3NpbmsgJiYgIWtlZXBfZWRwX3ZkZF9vbikKIAkJCWRjLT5od3NzLmVkcF9w
b3dlcl9jb250cm9sKGVkcF9saW5rX3dpdGhfc2luaywgZmFsc2UpOwogCX0KLQliaW9zX3NldF9z
Y3JhdGNoX2FjY19tb2RlX2NoYW5nZShkYy0+Y3R4LT5kY19iaW9zKTsKKwliaW9zX3NldF9zY3Jh
dGNoX2FjY19tb2RlX2NoYW5nZShkYy0+Y3R4LT5kY19iaW9zLCAxKTsKIH0KIAogc3RhdGljIHVp
bnQzMl90IGNvbXB1dGVfcHN0YXRlX2JsYWNrb3V0X2R1cmF0aW9uKAotLSAKMi4yOS4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
