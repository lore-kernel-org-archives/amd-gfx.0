Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B39C47087
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83686023C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 00:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83686023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079FC6EB94;
	Wed, 26 May 2021 00:41:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B286EB92
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 00:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQu0zKwFt7ZR4AXrtlk6PZ2MG8xZxhwOgXDaYRSVxmgwHNX769dVUSEPPIUn0cqA2lFvUSlrYsKrcGgYMuHG8y8Ih3pevFq99eqsHZQWi7/3WDkauSyfi5yG2UL+/YxxuCsOI/ZaleDPveicTgkzoUHdCEibUerTxaOaTGN/mHakV74h2SuQ4aQScxcJl7Op8RrGH/Ae4S2NGXb/m80TqB6WJub/e0lasd2kWlirTvxBKrBscjDUzic4OEdCLphZHL8ueKbgAHbttlZGUl0HG3n6lVD9J3NCxVzwtFEHfzGGEG7skNJAiXafp+klkY8dQhBo+3sy9QIlniQ7rfopwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=eV0HtM8u9DAYbuHGLKNgg0SA1KkP/8S1bg/OesVg5MvEwRVGTSSaXOe/jMG0UlrzXM81rvnItQICp8WtKU+adoMvPPDTY/GZemfMuDEDfnOQqocv61691pRiCUnKnswI35qxiijFUPvkSmiT0ypTu4PguC6yLqaCJwSsGCf690FbZcdrXu2YdSQuWo4w97RLoDI7M99GMqbKHe6I+pCKINXDHc1xg8fI6PoCB/sgJPnWd2Lw2YtkgwXgUKcXTyy5PjW0xpad1c42if7zXa8o29b4Q7RayD97jxle3PJOIUp2qRd1/v1Kjz/h+mrA/8Mhfw3njYNnaTGpa7b1bc5wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=tZoIZchT+CTg7VKuPkX34piiArYDA2Ew4bnHbdWXr8tZ/MBaKlLGXDOwWzehcLRBZtvYxlC48hUPZ4O6L3/Flt6c4gR3YCxLqCmoqkyo88Djw1MWFFW/2qLW+lifAlOvYCKNWx33BTX8Itx6hDoTU9p8W757zFg5j9HibImXAGY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 00:41:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 00:41:02 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Don't query CE and UE errors
Date: Tue, 25 May 2021 20:40:42 -0400
Message-Id: <20210526004044.58986-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 00:41:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a11251e7-5040-46bd-f8ca-08d91fdef05f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641C303B4A27FF30F0698DD99249@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wnhCWCILqWxTa3EKSkSuK+whw7GmvsNrN09QyjU3P8XtGLoz3/JVSKVfAi6Eu73HvFYh5cgHqdIXAjwWsLXoI5oO9L3Hgl5F+6L51W318T54XcDoGtA+ngTAB38xuPhFjHEhtrQijRnE35hVHV83VCMzU5kGB+dwzuBkswbrE3wMMHbK1or6A1Bas350V1Yvnb4ZzqMZc+sgxJuVcI0dp3TTi1cDsmhspie9XrUCq01tc8e2NcEiA4vSK0aR7JgG0db076GXR4deXHHwUOZXG94KUV1uKgXCenWesyiW6GMjRG4qdb9fxizDwwk/zTKkPJzx2WxBjwTGKY46XyKTLrOhdEj+lxfS9IDVu1xbguLE/7vAeF6QJkpHZZXu/ObZg+GgcN2hlwefLJu/i6LIJ4vU9eC51CwVRcT9gEBO/hWlVenPhxQgmS9KB+4wlJLWwmn5mACB3FuSuhLPdQoae4sQMluPHmF9ioGyK2c6pOHZikIe0eIz1zqAjVtrdCjhsHW3/vgTbx06iK+1vVtv4LGNRVSjiRmKy5PgHWKDCHw6KO0Bs3NU6rfjoVnOL+X/fkxZhYlQPrZ/faMcRZ6Of9HQcv6dDSBjF8aRBgYhv9Oy5wU+Pooi9PHg4BSM7SBqdvhKoMBmUfEQNrxT4nxbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52116002)(26005)(55236004)(186003)(16526019)(66476007)(2616005)(478600001)(6506007)(66556008)(86362001)(83380400001)(2906002)(38350700002)(66946007)(6916009)(36756003)(316002)(8936002)(38100700002)(4326008)(6512007)(5660300002)(956004)(8676002)(44832011)(6486002)(66574015)(54906003)(6666004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VmFtVHk2cDlzeTdVVUNQVEllK3ZSQ0E1UVVBZlVyRlh3NGl6VEdqNWZNR01x?=
 =?utf-8?B?b01IaHd0bzFlbThKNzJUeVRlL3ZaTUFVMFZpamt1V0NMUlhKN2YzajlxV01i?=
 =?utf-8?B?TEJDOG9hK3VzWXNGazQ0a0wvRGZITHIzWVpLdUNCNUx1Y2c2VFJtOEcyQlRM?=
 =?utf-8?B?TW91TjB4d3lOWWU0aGI3NkJlMXYyVW1UOWwwM1NLMzl1UldTRWRkU1NBUWN3?=
 =?utf-8?B?SFhBZXZ0OEEreUN6aW1rakg5OFNpclZYRVRqK29yS3pQZ2p6UkF2aG9YZnVo?=
 =?utf-8?B?ckh4TkhFVHlucmZXdlg0WFVPN1VsOTQ5TTZkV1FmVzFadXVZNDN1VFFFbkEy?=
 =?utf-8?B?bEtMMnE5RStsR0J1MUZBazQ2cjBhdnZBRXNCZUpmdVdkbVJ5SDNIaDBMYmdS?=
 =?utf-8?B?SkNIbit5WG03UVlwNVphbzFFaVJoTHRJdEZaT2JFeWNRZk13Nm9ZenFNME1m?=
 =?utf-8?B?Uk9BQ1VZNHBaamFRM1BpRXQwaGxqZm1CeUpjTnZyQzdyRitEN1Y5QnpoNHRm?=
 =?utf-8?B?VjAwbDFsWDhCSUJYVG5oUUhCWmR4Y3htVVlDZVNjSGVseXJ3M1pDdFducjhr?=
 =?utf-8?B?MDQwTFIyL0lXVHlCbmNpSmh2d1VhSi8zcDVaNFR1OUtnMm9mc1lGQnIzUWxs?=
 =?utf-8?B?QXg3R2xzNzY3VWRtUFpaMmNvcmFoZlgyREl0TXdIRmFzb1gxNWQ0R2JwZnBH?=
 =?utf-8?B?c0VldmluNWk3NENMdkk5aE9DekZEL2QrV3RydFhHeDZkcjdyc2J2U2tTZU91?=
 =?utf-8?B?TlRZZy9oaXF3bnRSYUozUWhYNlp4cGt6d1RSRURHWmVnOTNEZ0crdHVTUk5x?=
 =?utf-8?B?bXhpZ3hDOURrbXJPa2NNYzBwTVd4cnF5RjZ4RVZ2WUZ0djlNcVZQMGgvU3Zq?=
 =?utf-8?B?NTZ4dmVaQTV3azhNUkVQTXJBVzN5MHZ4akdjMWc5YVFCMVNINi9jZ01MdnBX?=
 =?utf-8?B?cU8rWjZ6Znk3TExtMHhUZXgwZ2dVNUsrNUk3TFBSRU5UTlBUZTVjRTVLblRN?=
 =?utf-8?B?ZGhYcDM2bjlCV2hlNm5wVG8zVS85alBqL0xFRi9vRHBCcGV0WU5OeEcxNXJK?=
 =?utf-8?B?T1ZaRkZQWHJkU2pwQW5TbDZwb256UENHYTZNUGlQRElBcWo5c2ZBQ0dINi9j?=
 =?utf-8?B?emltRU9DZk9uSG1vTHNrTDVwUFhXQ3FobUpkVlM2Y1hlMDl0TytJajVKby9G?=
 =?utf-8?B?VW5mUmFydzdzbzJ6eWY3c0J1TkI0cnUzRHYyVzIwcEM0YWRVbHlXY0oyMndX?=
 =?utf-8?B?YnlMQS9jTTZFMVQ1aUtXa3lQbjF2UUpIdEJWNnlYdDRKSEdvaXR1eCtOK3hG?=
 =?utf-8?B?aFB6MG8zOFhHRFFIUEtuV0pHUXppcXNDSU02RVZCZkJqdDJBTldwWDhLRUh6?=
 =?utf-8?B?WjgwY0x3WlYvSW1MUk1yZFYvQTZuN1Y2Mm5FZXZaczBhZHNvK3BwSGlhQnBt?=
 =?utf-8?B?Mll2Rms2akNUOVBlSG1odUh1ZVRaNERrOFQvTWpmV2RPOW1TR2gwWkFXeE5E?=
 =?utf-8?B?WDBQY0dNK3c4cUJ1NWFLcHMycUlXeGdzVll2cXN2R1p3bno3clhWeDdJb0RK?=
 =?utf-8?B?TUVvclJQZlZkb1JUOVR0eEZFV0FsTmNwTk12RytnUTlIeEIxNUMwYUtxb0VY?=
 =?utf-8?B?djlaVGxvVWR1TVdvVmNZSzc5aDczSW9jdExDOTFCRUlFYXNJTngvVGdjc1pP?=
 =?utf-8?B?V0N6dll1dnpIY2M4dVloL0tMQUEyYXlRNVJtNHNKRzNZVEZCbUdSSmVIUDcw?=
 =?utf-8?Q?Js96bGY+geT/QmoyXV49/B2kYtaPzN7mh8kgzm3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11251e7-5040-46bd-f8ca-08d91fdef05f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 00:41:02.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EmydtZjthucN21iXl8aOmNBOZnSLhoRsyVjUYfL7553q+rIAea/jrculRxJ1nX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gUVVFUlkyIElPQ1RMIGRvbid0IHF1ZXJ5IGNvdW50cyBvZiBjb3JyZWN0YWJsZQphbmQgdW5j
b3JyZWN0YWJsZSBlcnJvcnMsIHNpbmNlIHdoZW4gUkFTIGlzCmVuYWJsZWQgYW5kIHN1cHBvcnRl
ZCBvbiBWZWdhMjAgc2VydmVyIGJvYXJkcywKdGhpcyB0YWtlcyBpbnN1cm1vdW50YWJseSBsb25n
IHRpbWUsIGluIE8obl4zKSwKd2hpY2ggc2xvd3MgdGhlIHN5c3RlbSBkb3duIHRvIHRoZSBwb2lu
dCBvZiBpdApiZWluZyB1bnVzYWJsZSB3aGVuIHdlIGhhdmUgR1VJIHVwLgoKRml4ZXM6IGFlMzYz
YTIxMmIxNCAoImRybS9hbWRncHU6IEFkZCBhIG5ldyBmbGFnIHRvIEFNREdQVV9DVFhfT1BfUVVF
UllfU1RBVEUyIikKQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlr
b3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIERldWNoZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwppbmRl
eCBmYzgzNDQ1ZmJjNDAuLmJiMGNmZTg3MWFiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwpAQCAtMzM3LDcgKzMzNyw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9x
dWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiB7CiAJc3RydWN0IGFtZGdwdV9jdHgg
KmN0eDsKIAlzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncjsKLQl1bnNpZ25lZCBsb25nIHJhc19j
b3VudGVyOwogCiAJaWYgKCFmcHJpdikKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC0zNjIsMjEgKzM2
MSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAJaWYgKGF0b21pY19yZWFkKCZjdHgtPmd1aWx0eSkpCiAJCW91dC0+c3RhdGUuZmxh
Z3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfR1VJTFRZOwogCi0JLypxdWVyeSB1ZSBjb3Vu
dCovCi0JcmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIGZh
bHNlKTsKLQkvKnJhcyBjb3VudGVyIGlzIG1vbm90b25pYyBpbmNyZWFzaW5nKi8KLQlpZiAocmFz
X2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl91ZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9
IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKLQkJY3R4LT5yYXNfY291bnRlcl91ZSA9
IHJhc19jb3VudGVyOwotCX0KLQotCS8qcXVlcnkgY2UgY291bnQqLwotCXJhc19jb3VudGVyID0g
YW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsKLQlpZiAocmFzX2NvdW50
ZXIgIT0gY3R4LT5yYXNfY291bnRlcl9jZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQ
VV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19DRTsKLQkJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19j
b3VudGVyOwotCX0KLQogCW11dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKIAlyZXR1cm4gMDsKIH0K
LS0gCjIuMzEuMS41MjcuZzJkNjc3ZTViMTUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
