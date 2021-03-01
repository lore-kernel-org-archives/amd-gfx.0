Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 03:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026F764D99
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 03:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026F764D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C08B89E9E;
	Mon,  1 Mar 2021 03:12:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7DB89E98
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 03:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjvIqPbcG/jtfP8rBygJSkdGFYZ1ZTxNAPJtV8C5ynez4ULW5RGkSIhtGWvNMl9P0ONtaM/mSiPXsFTgoIRtOMfR0x9SrLlQwiJDSkmdvxbu93qczQsLMGKf6eF1LNOd4hLVawshRnnHlbs/OS+eSfMkm3yVfZYIb7YDZ8yh7uDwq6Khmi1a+N+QK1cgsluN6GlUo2AZjppXinI9IUdEUIIa6AgtWjyzTbvJ+X3ebsEq0xGEiarDiIhkbNY87ccJOEnvzgz8tezVWd49QnqkpWPItjhWzLSCFSHHoQ+6lCUdIIv0FsiyoeWRW2WBQqN3vwxCYx4yjEl0E+bJDmMZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEMVu2fjceBlBCL15iSTLXoG0V5By6yX3lxfl7elGaE=;
 b=EMThi/adXmKSje4F3YHLTYHb9wujjUoAf+RE19x9mi7Hs1GkRil6GW/BTBRvcU63AnkV0K6GYsKOnWCWy/StOwiqd1+C2Zy//MWJAo4iakNyIPXsRr7NVyfVnkHP/XPmEqO+65TGmfrk4MI2StWF1qscVH5lqiwxUjWwugHrFTRMNfxOgR1g5n0PzXm0yeRuCSEoQ8q+K8xBRmMBq8KlQUHxRJvcjM/zR3ynHYpQ7eKN55s17TVEegmkhLiH5PqE0o+/W3HJlHzbWZtlftsq6ts3rddUxzWb0helJc+5z7I0RI1B5l/PgbsgsM8uCYuMjakwQaj4/D18EgU0JxgG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEMVu2fjceBlBCL15iSTLXoG0V5By6yX3lxfl7elGaE=;
 b=1KFRScnsX+ySfGO4tBX35UAxJYCIKoTR3x9aFYVYXo0G5DfQpQZ/YY92mYVD7VggiqnxGjlTs3Z3kd+yCH3Qy+n4ccO2cJiNmiF7Tdyd3i3e6LjVSHw98cwnyN0MUO4vwo//miJZVXAP1db85w2Kie++6mT3qIZGfwsvg+Gqdhw=
Received: from BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28)
 by BN6PR12MB1569.namprd12.prod.outlook.com (2603:10b6:405:6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 1 Mar
 2021 03:12:09 +0000
Received: from BN8PR12MB3633.namprd12.prod.outlook.com
 ([fe80::9d24:2886:951b:b161]) by BN8PR12MB3633.namprd12.prod.outlook.com
 ([fe80::9d24:2886:951b:b161%7]) with mapi id 15.20.3868.033; Mon, 1 Mar 2021
 03:12:09 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Topic: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Index: AQHXDkXh5ewyTkSdWUegZ46EyTRWyqpudI/Q
Date: Mon, 1 Mar 2021 03:12:09 +0000
Message-ID: <BN8PR12MB363335878B41E02A481D3EAF8E9A9@BN8PR12MB3633.namprd12.prod.outlook.com>
References: <20210301025130.17402-1-kevin1.wang@amd.com>
In-Reply-To: <20210301025130.17402-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-01T03:12:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e83843e0-cc0a-44aa-a1f4-0ce4f0b037de;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53dcb81f-f1a1-4f0a-0e25-08d8dc5fcd10
x-ms-traffictypediagnostic: BN6PR12MB1569:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1569B7B467A766FE8ED709B88E9A9@BN6PR12MB1569.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EIlaYn8ri3w+N7sHwCk9+5eq5bf/HBqhllMxM/RBj4lKGLMimm+YgZptilxHVyBqDrhkG7gm2RDfgEkoyjKiuSRS2Tp00l2jssv0VyimcYNSO3woeyjXZJdJbG576RvQC249u7aSRwgrU1nCQTiFvly18XLl2CR6T6hVKC9zCpIX483b4F+OWQPzOMvl4xdqKJrW61+c++Bw5yXg1pOOz4XHLNhXKrt61LFJdCd/q0mG3jatE6tAgsgx5Q8xnOMJ90jnBEOHbgJ7JZ1RmElV6s85xgju1VtAWDsVBiEQRkc5g2l3NZv7pmxiWOncdajFKVIwqRoASwULYeOpokhYXPGywV3rRSnVWdyyYCjiCYVfvv/jM5euLx73A7wUShUOmq+hhI4dEZp2X4Pt8u7W0dO0FsFriRxJ1vg36MfsCrGVv7/rTAfOT2aYyLQannqltePIN8RefVCf7fKCq3qaXDP1w3LrqxThLi3DNz3Jqqrqo8yz6lGSORDyPBa5CZi5sj/2NewlIj9P+QtMUdH98NOwxh/5M4CD2CIiyRRzkDpNWCDJDjC4n9Owpzo86SoA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66946007)(316002)(71200400001)(54906003)(86362001)(110136005)(8676002)(64756008)(186003)(66556008)(76116006)(26005)(66476007)(45080400002)(966005)(478600001)(33656002)(66446008)(4326008)(8936002)(2906002)(9686003)(53546011)(6506007)(5660300002)(83380400001)(52536014)(7696005)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N66q8soXak2chmJsmJBovTpePPmV9hX7wAgjJ2a8yI4mWetpb4V5hxCDxQVy?=
 =?us-ascii?Q?grkHQkpQRbLn41H1ak4fwEGNd9X1369hfZuOC1MR2gkz2rJV+TKIo8+CXlj/?=
 =?us-ascii?Q?c1QKyI7aKOjfuDOYPGog9T6XXeyGl3GDxYbnvdNXLNt+9aIRJgYi+Vp3oBA6?=
 =?us-ascii?Q?NrOucZqrlbSi5W2KU2NgOkrYC9KJ7QU/XQInO6ZlrUB6g2rqUEnGUC1WSZuO?=
 =?us-ascii?Q?w2L2KQ35DuQfo7qwkBCgOoY6GLKYaXq7M1ankgwB1KfoIH97TUqKcMPunEBv?=
 =?us-ascii?Q?i+8mGiSpFrn17ycBmOQIBZposcKQzOMH2qn8eFaocb2AfbMs3wq798+G5GyP?=
 =?us-ascii?Q?jpJrjdqaHlmXSBLxSuYNORwoWtD3sOwXOGkUGA1GtVSiUlZt8yEti9uWKGQW?=
 =?us-ascii?Q?JSvhoA3qa1SGTHqzKZ+MxtKuPCtIBzo5AYnfkFZqAiNuwW6BZjYkLvdpN/8z?=
 =?us-ascii?Q?E7ske5eMUedxzWrjdTJAhYWzpzzkNl8qts70WX/AmUzq8i23gMpLrI1AkY4E?=
 =?us-ascii?Q?MG7sYygvtW7Z1SwSpEgcOuzFFTLJJCzM1r6C/eKVOds17+4gQX9zP9X7R+V0?=
 =?us-ascii?Q?VjKQgnhaFGQZEdEYgYXhb0veLHH4t7v+fvQ2+6YS4di9PGdc7/lm4HyKsSXx?=
 =?us-ascii?Q?6HF3ubfQJwuSLV3Cvf0rBIJrBEgZS3xQLPXUyPUT1dvUkU6Zcu1lOf24xOm5?=
 =?us-ascii?Q?hyn9s/hhB4gqjQG9PKwr7XjVzXELdGIGv02e72Wfpr6aPcjLUAs/lMYcWyUg?=
 =?us-ascii?Q?BmjLXhJ5gibKpPLxzA8v7AdrpeiUaGMqWTQpnfpFOyVFB7rUEt29ogc1Jefx?=
 =?us-ascii?Q?8AOg6279kvWrd2Z6ugonIPhfvTYTkm0EX6y/mYOsH4u07zt4qOX9Clr4OxsP?=
 =?us-ascii?Q?XqhqKWcLRjwm4i7XsiV2sM0zY4mbksVE2HLM39GcERRFZy6ntpPrmrohZ/1Z?=
 =?us-ascii?Q?9TFsnh0vfW4P95isYMR+bPMvshmrpaFlMtDbPS3Yf8euIjKqke44vF3LXMH8?=
 =?us-ascii?Q?c9Tmh3ZHu7Y0vcXw9lZPPy6zVdJDN9g4aDKGgZElI4cXjJQ+YHlVwHS6Syq3?=
 =?us-ascii?Q?z2utcRnMhA9jLUnC++dt1L8/mpefWuJYJQe4oLSE+K4TnFClh7+k95PAnMQI?=
 =?us-ascii?Q?poBPFYogAIq0vDYokafaf8SpXLhbQzAsk3RUluQ2mZx3RQeWABueaU+0CsQi?=
 =?us-ascii?Q?QDCA+B6dYjYtBYA39op8jbBhNXKspADZw8dHzA6iXAZ1WWzAcpRm0PToVJo3?=
 =?us-ascii?Q?mCzHvuk73hUN3ThFqATrRaMuLTUZW5DRubimYlNX2erjrc4DdQI870oHAT3I?=
 =?us-ascii?Q?c/FkuNbSTWqr1Ry/AdiQFA8n?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dcb81f-f1a1-4f0a-0e25-08d8dc5fcd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 03:12:09.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28QDOTDvGznd+KZ4WwraO6xOaXKgVNQ4KXVeRLAQDN3Pa7fOuH+fxzZFo7V/7Wdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1569
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, March 1, 2021 10:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print error

[CAUTION: External Email]

miss RAP TA in loop ( when i == 4)

Fix:
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reported-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a5ed9530f542..6c8ea9d26320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1472,7 +1472,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
                   fw_info.feature, fw_info.ver);

        query_fw.fw_type = AMDGPU_INFO_FW_TA;
-       for (i = 0; i < 4; i++) {
+       for (i = 0; i < 5; i++) {
                query_fw.index = i;
                ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
                if (ret)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Ca7584153dcb441572ac108d8dc5d02a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637501639327273332%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ofHeQH5qgaqgtOYPasHstlj%2F8d2s%2BiPKpPOppXipVTI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
