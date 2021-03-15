Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F6C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3B864DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3B864DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDDD89D79;
	Mon, 15 Mar 2021 11:22:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F55989D79
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBitiFF0+LJEbFJ0XsnLm2olWur5hofKMp693E8RYUF8H2hKobXz3FjwiA3sp4hZCtX0jmjsgME2c9wcvIG5YjNSs7pqrajVtytNWohOpRUrXTZIp6HSoAGtmMFDfiQOim6O0Y+ASNW83NF12E77H1UzP20mwamsZaQSEKZYUSOfNGrXd1ner4kXldf0IxCcLstA7Uy2nXPiPXDz4deaaRXhnF3mbFRvIGfcRlMh1Y4uVgURq6a+8IzHDc9b6muL9zxqtnx4VY/Qypi+Wv6m13InPe5GRRZHBpBqqAJVXI5+5reQo4qBaF3+YTMbl/wGgREIavQX3Nu3nyVQUOpSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yxX1Tk1ZsrivElMxE+Th5GxeTQ6PFhmXc1NZMYv4zo=;
 b=P2e10QB6ntTJHrA776DLRlQjG0fSiQkxJ1/94m4JC1YYrTdqUHNSXT1cxKlmYCx6p7YxJrLCN0sdEV2r+9KuiHyBH3VPr+zsPe6uVF4oLwgpWwdrSUvaTB/DY5hdHg5INr+ufKQzBbCe0w0AwE4yiOskjyqVNmT5qywL3CNISGytDmiQcBtdC3SlZmfVubVvDVh77PRR9nvOkQOHqCLgRWqNn6dvY5UZtTXL1s+ohOvW94NCKVKjdQghxA3uj22+OoZV3lA1lJ6fbc6vd8tqHyK2NPo10xD8QM6xJHwF7dpgGhB49IXRNWcLPbs473Rg7Ok8ljV0X9gi8yLBn0dWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yxX1Tk1ZsrivElMxE+Th5GxeTQ6PFhmXc1NZMYv4zo=;
 b=MExznIu4iKYtNA08pSV/RzRW+GLCdEa3LjUnqsVPDl66AIo+DC0VI6xLzZe4zQdgiYBV0emeYoA3p8Q8OtXtgiRWfin7RbZtWosfMzr7DIYNGnDSd4qIDRZyUvjvIHxhRfezs3CzNnxf5Xak4rln9axxT7Sq4vaZcAOIqFL4Xaw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:15 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:15 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/23] DC Patches March 15, 2021
Date: Mon, 15 Mar 2021 09:39:47 +0800
Message-Id: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6478deae-c4c1-497e-ae9c-08d8e7a495df
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46179D2CE16F32CA23F30285976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hg1LLMg5oiuWqHa9CL/eG3KRVVTFjoyjR3jqoGtb+HFMl2BXzBTki5YT6RuEVRw7thU4UgWFsQr0kzwRSoCqTyEyaXCnTWA5RZa0nQ2oxcEx6u32YkfVcNDezUo14Yi/6TEZLlCyPVUNmQnx3NVakirvnjqgkv754bPCYpa2znHORi/pYlm4CR52OXcdGs5YXeLU8jLl6K28UXMmKnlllc5Mgxn0BIX6jV1MVGEuoLkcD8lOgGxIxDTAwmKoFhD8jGiToPfMd2i10ZCBTfV45UgYLw9rbGjDATRczfJBxm0UMLeHJXTQ7/7IK8ukCWRR8c+ENgm+QGy7jK7kQPd9ZemnoRiZk6lFUjD60bLutJXFuI/4zOxT3mzSpTt65iunhqpnpu6NK0LY006d9SvmkCttCDYmQt5ZLWSZ9rWrQyxszSeLZuPqfaEF5PY8D7O33N0rDMlfPjLB/ueSyW3YkhdSHV2IUYP3W9/WXUS0yIZpSw5SYdpCXU7RmdKQYWMcd8sBqQPX+yV1qwkfIzgZ3ucn9WU6jJkql/Ftl0dmnviXuPe1dv1CrUiy2emX8UI6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3NZY1VZTGRvMGRJbldvVUlUTVZ0R3JZbk9meEI4Y0c2UzVQVXZHbWRkVzlo?=
 =?utf-8?B?TTZodTFkNGdmR0dIWTJFZzQxdjFEdW92VnRmQkJSTFRhR0c0Q1c4TU4xZ2V2?=
 =?utf-8?B?MnRmMjRsbld4TEdhV2tId3lvaWszdW12OSs5bkZaMzJmQldidW5iVHZPbkd1?=
 =?utf-8?B?WXVDak1LNG4wbmhmcDFGMjRmSTVQVFkzUHNhcVhWbFRUOWJ6ZE14ZW5mOG1i?=
 =?utf-8?B?WDVNbnNGaExVTWtqa2lBc1BnMW4yM1ZVbXlBNXlyaEMyYnoxWXlpRW8rTjRm?=
 =?utf-8?B?dHlrVXFIdU5SRDQ1RWpEdnpHMHV2L1VUczBNSS9TbFFoTzdsTU5yd2pxRlhu?=
 =?utf-8?B?TzN4MExRcy9uK3BETzlFSkcxbmFIVUI4blE1bXFGRi91VHYyaSt6R1BWTGkv?=
 =?utf-8?B?ajhlZHgrVFE3R0pQUXdYdU0wckY5UzBWWUVBM0dDajV4YjdmQzc2aEZDT1dj?=
 =?utf-8?B?SjI4ZmMzUENwWHk3eUd5REJFL1Bvb0NWRFgvb1hJYnRuaU1raXo5SHQ4Zkh4?=
 =?utf-8?B?VGZ4U1FrMUV4cmRVd3FGdEkyTHNRZkJTOWhWWkhrZlBOSnBnZ2QxUWd1Y1NX?=
 =?utf-8?B?dEkzbHNISWh2REd5dlRCTW9xbTM3MjgyTzFXMzJVMXBUQ3NMMHZmbXl3eGFt?=
 =?utf-8?B?bzlUbStEWndWWHNaNCtmMU9KSUU4Z1JDRm5lMFNQaW81dURzbUp3MHBUYXM0?=
 =?utf-8?B?bDgvQ1ZGWUM1NHlCd1dXdlFLejcvTjFySXJYYWpHbFovZXBoY3JLdUcxaFV5?=
 =?utf-8?B?WGdCUERnNEl6eDI0REV1eFF1c1U2TDdka21YVkxrQ1NHT3o5TTM0S2djTjdU?=
 =?utf-8?B?d1VQUmJLdHZsM3dQTUtZVDZISEF3SmxyZGg2SkFNV2JacU5XSmxuUlk3OStr?=
 =?utf-8?B?NlpSeE5YcE95UTY2eG1nUXA1RWZmaGZMYWlmckxacGRYbGFhZ0lPUHJWbU0w?=
 =?utf-8?B?bHlKa0w2R2o0TVgzOTk3QmlvRFY2a2JUTGJyMGd2b3ZyMFNzZzYybDQrYXJk?=
 =?utf-8?B?THhEVzFpaW9VckgvT2dWSFZhN2ZpM1RJVlc0Nmh2K2ZzOXd6WEdSbldUWW9z?=
 =?utf-8?B?N3NLcE52Qk5BS3FFRTRWZWdxWTRRQ3lHTlhYcHIxTWhkY251SWhZeUNNRW1S?=
 =?utf-8?B?VTJqWERqSE1rYnkvdEtjQmFTQ29raEhUMFR3c2JYa29HTVFUZ3prSWFTbW5O?=
 =?utf-8?B?TUtkb1JmZHZHdTJBYXg0aFp6eEx0dkQxVHBra2NOeVdZRFhWUFdnL2lRc0c2?=
 =?utf-8?B?eW9tbHErSjVUOWE0SUNXbDJsdGhGanNiTGZlcDNqVmtPVTdlMWlleWJiR1J1?=
 =?utf-8?B?SXRkSEsvaVNwQnZlSGUyR0svOVB3cENmbnEzTWs1UnJ0M2kyWndVa2l6SkZT?=
 =?utf-8?B?UlVuTzRsb29EK21rZEs1Rjl2OUNRVWlJV1lWMWVPcUx6VnRxOFE0TDUwcWZh?=
 =?utf-8?B?aU9kS1poTk1sSWJ6b002V2IycWhnMzNRTVA5bjc1RlhOd0g4VURsOEV5d0RM?=
 =?utf-8?B?Q0E3OU1uekhkUXJ5Y0pmVnpSWGd6OFBwYW9zdnlLRjhLT0lUQXdvOHpMekk5?=
 =?utf-8?B?VEt5RkZ6TlZCRk9KSWhXTklMOXJmRXZwYWlFS1NOSGk3bmc1U1IxWjBxQWdr?=
 =?utf-8?B?SUhCdG5DbXM4Wm5NNk80M0dwN1FtUEhFQnJGY0xESkRCdlVXZFNSVWE3ZjZM?=
 =?utf-8?B?czluTGJkVjJRS2xtNUwwWVJqTDlGUy9iZnJIUW5Xb1NpUDZJb3pQM1AreS9j?=
 =?utf-8?Q?RMy5Mawlr+dteAN+fiAObCNXohbQzVK4FMuVqen?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6478deae-c4c1-497e-ae9c-08d8e7a495df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:15.0840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QivbF1i2ngxtfzjpO4UdnWUe/6yfqyja4THTbCMWySw4sY6xMmewwHoH9Zz3WeEAk2ouxsgqVXe7Gu73Q2YPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Add debug out when viewport too small
* use max lb for latency hiding
* System black screen hangs on driver load
* Fix UBSAN warning for not a valid value for type '_Bool'
* Fix for outbox1 ring buffer typecasting issue
* Bypass sink detect when there are no eDPs connected
* Increase precision for bpp in DSC calculations
* Add changes for dsc bpp in 16ths and unify bw calculations
* Correct algorithm for reversed gamma
* Remove MPC gamut remap logic for DCN30
* Fix typo for helpers function name
* Fix secure display lock problems
* Fix no previous prototype warning
* Separate caps for maximum RGB and YUV plane counts
* Add debugfs to control DMUB trace buffer events
* [FW Promotion] Release 0.0.56
* DCHUB underflow counter increasing in some scenarios
* fix dml prefetch validation
* fix dcn3+ bw validation soc param update sequence
* add a func to disable accelerated mode
* Fix potential memory leak


Anson Jacob (1):
  drm/amd/display: Fix UBSAN warning for not a valid value for type
    '_Bool'

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.56

Aric Cyr (4):
  drm/amd/display: 3.2.126.1
  drm/amd/display: System black screen hangs on driver load
  drm/amd/display: DCHUB underflow counter increasing in some scenarios
  drm/amd/display: 3.2.127

Atufa Khan (1):
  drm/amd/display: Separate caps for maximum RGB and YUV plane counts

Calvin Hou (1):
  drm/amd/display: Correct algorithm for reversed gamma

Dillon Varone (2):
  drm/amd/display: Add changes for dsc bpp in 16ths and unify bw
    calculations
  drm/amd/display: Remove MPC gamut remap logic for DCN30

Dmytro Laktyushkin (3):
  drm/amd/display: use max lb for latency hiding
  drm/amd/display: fix dml prefetch validation
  drm/amd/display: fix dcn3+ bw validation soc param update sequence

Jake Wang (1):
  drm/amd/display: Bypass sink detect when there are no eDPs connected

Jun Lei (1):
  drm/amd/display: Increase precision for bpp in DSC calculations

Leo (Hanghong) Ma (2):
  drm/amd/display: Fix typo for helpers function name
  drm/amd/display: Add debugfs to control DMUB trace buffer events

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for outbox1 ring buffer typecasting issue

Nikola Cornij (1):
  drm/amd/display: Add debug out when viewport too small

Qingqing Zhuo (1):
  drm/amd/display: Fix potential memory leak

Wayne Lin (2):
  drm/amd/display: Fix secure display lock problems
  drm/amd/display: Fix no previous prototype warning

Yao Wang1 (1):
  drm/amd/display: add a func to disable accelerated mode

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  33 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  43 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +-
 .../amd/display/dc/bios/bios_parser_helper.c  |   5 +-
 .../amd/display/dc/bios/bios_parser_helper.h  |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  34 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  11 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  26 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  23 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   7 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |   1 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 105 +--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 668 ++++++++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 33 files changed, 758 insertions(+), 362 deletions(-)

-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
