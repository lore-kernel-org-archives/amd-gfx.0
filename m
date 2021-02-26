Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E5C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D8264DDC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D8264DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6F66E134;
	Fri, 26 Feb 2021 04:37:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D78D89F2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRV3/bLoJRZW3PmbgQ1IwjBw1qK4y/H3W0ug8nU3TtTl54/i04xFmoHSezQdaBfC5AlMZoF0X7t8EDecK/U1RLPX6isdQydBVqs8peW9IEXaWmpbV5Gtf4hTYTzYcL4mUjc4DIfRPLB4ODISuD7W0u89/AWwhi+rjzQuiKSxpJrOgYnwxd/0Lut9V19P90H30WBnUHMVYgTalNm6mrgcI1JQKaW4ltZA50dChST/XUiF9h1KWP5xyTiJAinIyUwuR53LaHviv1LWaPHCD6tXWswW1PVLSdrGx++/e0olG4PoPFMj1HCjGVj5YgrpzUKHRYyr6sHiIkhElGqc/rcf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKrotVQnDsnGHytt2Fq1aSENPHm5Fi/6AzYFvIfMqf8=;
 b=BkbYSCPonelKppG3Mah9ttODS63O6wpTFmQG/E+SL/RZhvlP4av3I1g3+mOln7rqbGDTteHX2D7l4MQFWPzDJpIDwxz1snrLeGfua2gsRu13kzyRThVa5C/aUJKMR0x6InrfyepktqwijB9Cm6lWSmt//Z/sCXIyBdv5tNOUZkST4bf+/o8BSOIXg0f31ktmFGub5utaUpNWQXYZsGRTujnFbHa8MmZZ8cjwwHxgkPlv1hLUy9Fp+SqwPzeIRet0JEPTg95PsaZQseq3o5x3ciLw8A6l2/vabmr2TpeJlnqyEWWNj1X5/29NgbbXs275hwfXivDlt2OZMM3V1Z5KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKrotVQnDsnGHytt2Fq1aSENPHm5Fi/6AzYFvIfMqf8=;
 b=RDB6dEnNZMBxhbZfsqKWSUphFe1HeSKLemTKxA+upFDjIDd9UIQlKlQHnb7LNC1bRVEWsi2Ude5b7QdKDgYCf88XFtd8qi9UcdD2sgBaYVMa2/mr+jbA6/TzpQ0tg3e882aT3OKgsCSVcgi+5MPhsA1UH/7Nug6Cin9hXLfE2K8=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3673.namprd12.prod.outlook.com (2603:10b6:5:1c5::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31; Fri, 26 Feb 2021 04:37:05 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401%7]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:37:05 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header
Thread-Index: AQHXC95evJ+xWr9NBE6NeTIELPG/fqpp2FGAgAAA2NA=
Date: Fri, 26 Feb 2021 04:37:05 +0000
Message-ID: <DM5PR12MB25339846CE83DFA051986EC9ED9D9@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210226012556.10811-1-Dennis.Li@amd.com>
 <MN2PR12MB4078C6619A293123C3616CC3FC9D9@MN2PR12MB4078.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4078C6619A293123C3616CC3FC9D9@MN2PR12MB4078.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T04:29:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c596c0b5-5ea1-4acc-b694-690225521466;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3b853a3-2917-477a-21a5-08d8da102b39
x-ms-traffictypediagnostic: DM6PR12MB3673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3673C8AED2C04B1099CD04F2ED9D9@DM6PR12MB3673.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8VgDn5CAJjvsrI1nHwbrPx4TmeUWXlN0C0wVe5/F87yHQNCaZ2nlrO8v+yCLMOCs37oKJwQAsZeRAPp9z3CAyhHpPphQtPJwYyojRwe3Xmv7bGknbxjEKNu2vZPPXwRRpwgE3ZRngeqsLwwEStU+G/n9Zk8nu/mmRXk8z05RCFeLidPGmmU9jNEx7vLc8Q4BxZCdgq5wfbZIypgW0kdDYWLNOh3FkaqgJL1f5fUgxXzm2oxHx2xHKSQ98rOBcZQrS8qCJlhk3lH+MhRlO7C98J00d+XB209VuLA03+8F2aogXJ2lnG/v6VULH0E5oGL4gesNnBZkvOl7dOlZMqNuyyrPrPVGgMQieutms3X4zYHFLBppKymuqtR/sRrLZBBVkCjwocmH6bNX8nzSP/QAKNVqPZj8HORrtfNPGv1clh7W7MOpSvyB50jAit+LhqR9iX6j7tgma3aqsxRkLMLHXX+IUWiuCFs4QRghpXSAdfdijzYQLEg1kkaFmaJEpyAIayZcZDYfX453l4hKL5dGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(71200400001)(6506007)(53546011)(33656002)(5660300002)(52536014)(7696005)(83380400001)(66476007)(66556008)(64756008)(76116006)(66446008)(66946007)(2906002)(9686003)(55016002)(478600001)(110136005)(316002)(8676002)(8936002)(186003)(6636002)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?akF4TnNEbWRPZTNZb1RqY0krYythbzFoUVJ5YlFIYjZ6WGg3dmUzd094akNw?=
 =?utf-8?B?NWRTV01IcFhHTk9hWTlQV1ZidnA4MHlFeFpMS1JYcStlbWl4SWlhcGx2dzJl?=
 =?utf-8?B?cjZ6Nk1MVkVJbkRkbVJ3R1FldmZIK3JzYkV5Y2ExSGlVYWl5eklocUxSY0Rl?=
 =?utf-8?B?VjdqVC9TeDIxcnBtWDFIY1VZV25PZFNxMUpnZlRQdWhkU2VnTkM3a1hLUjg3?=
 =?utf-8?B?K3JBK2daUFJaVjN4a0dhTFRNRlk4UDE4MVJxbHNaMUJUQ0tHbDhocFh4aUox?=
 =?utf-8?B?V0xWcWsyblp6WHIrREhGNEU5aVlHQVplbkF1UEwxSEMwcHcwRDZjdENWMU81?=
 =?utf-8?B?MGcyRFBMU29nUmo4QWpQUDVBVURUYWFGTEhxOG5aN2syV3huTis4emZGN2tS?=
 =?utf-8?B?RzQ2V1ZSNGRHNTZVM0FnZFlrVitjT1FwQ3Ztb25uUGNCN0djK0VFWW90Z01z?=
 =?utf-8?B?RFMyT3gxYTJtK3U4cEc4NXM0dmFSSE5XZ0cySGtlYXllL2t2MGhYYTY3Nk9n?=
 =?utf-8?B?ZERDNFZNOU9wbVlENm0xRFRRaTdseDA4M3lCUWhFZzg0TWFjZnY1Z3hCMW1E?=
 =?utf-8?B?OVVaQXdxQW5SZ0pSZUtpaC9SMW12YktFeUg4d1FRN0xrMTdraFF5MUtFQXQ4?=
 =?utf-8?B?ZlVlN1RxTGVuU3hpR0ZTVjl2UWZsWnZ4SGdpbEdOcUhLRHV6SlQwVUNHZHhJ?=
 =?utf-8?B?cXk1dExJbk5BcnQydStxUzRHNzNmRG15VEZzUlg3ZVVTalVsNkZjbmJ6SmZr?=
 =?utf-8?B?SFUvcTJPQUdCRzBUV2l4cEMybUVhd1Y3c08wYlRXdTVUU2ZCOXJEQWYrTVNw?=
 =?utf-8?B?SHJKejlobDJQaHFNMkJzUitmTW5qRVg0Mkd1QnRmNzBnV21rR2NncjJEa0dj?=
 =?utf-8?B?VnJOais1cVNqN1laR1hlc0c1cVZSbzFsbkdMSVpRays3b1NPeWhwR2hYQnRS?=
 =?utf-8?B?eUpBcjVjajlLZy9qdnFCRDMxbGIxTkhFaG9SM3N2Ykh2a2daajd0MFVKZjNn?=
 =?utf-8?B?cGlOYy9EM3UvaXNzMjBsZVB1Y0JabWV0Y0dqRW9JR0tJVGhvNnRVRUE5MFB3?=
 =?utf-8?B?OWY2ZlByeFhEdHMxeksxbFoxNG1IZ1VIS2xKVWFWcXRFeWRQVmJ1N0JzUG80?=
 =?utf-8?B?TlVkbVVFTkh6UXdaUUJBTGZCelRjN1NPNGJRTUZiUHhUUzZzT1dPczUwSmJw?=
 =?utf-8?B?MEVwWng3dXdFN0hMOThhbHIzOGp3ckgzcThFSThTeUZYYm16eDNjNkVDWjAr?=
 =?utf-8?B?MUQvM0xpY2hVdE9NeWUvNno4aEU1eGdyV3ZZK25TQ3kzRDRoOFRlcmxtWHcv?=
 =?utf-8?B?aGJkRnlwL2FjRVpMckd4TFRQdGZJdFBxNU9KZHhrSG9mZW4yU2JFTEVUUzlu?=
 =?utf-8?B?cE8rRkpiWGxiVVNyQWNkUFhJSjFzUGVRZHhVYS8ySUphY2FEQTZicHJaU2Q5?=
 =?utf-8?B?aVhsSndrTUszWjVhaDdOc2U5b3NiNjZBZDVoVFBvc0kxZ2l2S2FrR1dPQWo2?=
 =?utf-8?B?WFplOWYxVzJwaU92SHhXUGljWHN6RFpJVWpnNG45dXhhNlBlOXVhbVN0ZFBR?=
 =?utf-8?B?S05hOFNoSXlvZlN4Nmcxb0dWbC9KQWd6WG1zYlFhMktzc1RZYzBLeWtNZGhF?=
 =?utf-8?B?S0NOdTkvTjJiOVpIZUhCSVJ5NjhFc3NhZ0liY3Nqa3RlbXJibVByWmowS0VR?=
 =?utf-8?B?VkpQQzVMUy8rcVZEOElxckpGQUVnMmNGTlVXbGVvOU5vQlp0aHdCV2ZNd01S?=
 =?utf-8?Q?EoVBe/xWuh1o5VaqDt+2M5uqowUUmn5V0icBnc8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b853a3-2917-477a-21a5-08d8da102b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:37:05.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mhWX76/JKiM+1yVauaG1OAlBvHG1bMnTez/OTjHZgu5GHdFwU4SnMaG1EDRivz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3673
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Hawking,
      Agree with your suggestion, and it could further simplify our codes. I will refactor them again. 

Best Regards
Dennis Li
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, February 26, 2021 12:30 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header

[AMD Public Use]

What about merge this function with amdgpu_ras_check_err_threshold?

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, February 26, 2021 09:26
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header

If the number of badpage records exceed the threshold, driver has updated both epprom header and control->tbl_hdr.header before gpu reset, therefore GPU recovery thread no need to read epprom header directly.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 19d9aa76cfbf..4310ad63890c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -439,41 +439,19 @@ int amdgpu_ras_eeprom_check_err_threshold(
 				bool *exceed_err_limit)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[EEPROM_ADDRESS_SIZE +
-			EEPROM_TABLE_HEADER_SIZE] = { 0 };
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct i2c_msg msg = {
-			.addr = control->i2c_address,
-			.flags = I2C_M_RD,
-			.len = EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf = buff,
-	};
-	int ret;
 
 	*exceed_err_limit = false;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	/* read EEPROM table header */
-	mutex_lock(&control->tbl_mutex);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	if (ret < 1) {
-		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
-		goto err;
-	}
-
-	__decode_table_header_from_buff(hdr, &buff[2]);
-
-	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+	if (control->tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
 				"threshold value when reloading driver.\n");
 		*exceed_err_limit = true;
 	}
 
-err:
-	mutex_unlock(&control->tbl_mutex);
 	return 0;
 }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
