Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A5C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 05:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EDB10E19D;
	Fri, 10 May 2024 05:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JGzfq9Kz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A8C10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 05:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1C6kHwnl3EaHEce6i57vL3jlzcHsi4J3YibplJyzkip8ax/OWzFjbxFyBIvbYPisFw1MfmZHVFDFXkSzRNslAqoawbmLKwMb9uaSFFk7YVZm1bfILa4R+FmP15dYWqRzl0gYOYBf1htrDGj5JPfT/LSaUpyFakoa6vdGcq7Jy9byQdVi7ds9xaabzB2MdRBkWTUHR6rdH3yOBHWiuI3QzMa6H0aA5t2jLmiG/0AE04Vp/MAdu3W6sjvxTugex5x5P6CDVXi+3EA7dgQIKSkF08RUlZF3bW8LWvLFi/B3R43tGAX6e97Y9Ea/b/hFUWu7jXklB6xpD7VK01kmeBv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0U7Um84U/gFiTHCoZYQ34Pr26A5DlU0eq+fSjKaWIs=;
 b=bOcp2BFUUnSDulTHiq7Gc78ECMXSzunaIkHW/gye/5CB08q/ZRsaNVcrngtNUfmHr+v4LfEGRSI1Zw3GzbmOxH2+rY8mhpQVi9WFBNLm7qPZZA+Nt95ch4wLrsAsKZSgOj3OqHlshbJSSaL+e1CJcHkDyMJvlT6VhZj6l1SXmKfmtHR61/Y/MyQWznbUmaMQZkpaZYXYJbM47ZiQM8SPR/lA45bOzIK/mgiXfEMkh/DxHI540LS1f76DTg2+xgaQWRvaR1HUZan/BUWPlvFaTzkt/NGHtK06tsLpyygwkx495+HzSz5zgbpmCKGTZ1gAAoUdbYBdzMK47Mm3UaL2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0U7Um84U/gFiTHCoZYQ34Pr26A5DlU0eq+fSjKaWIs=;
 b=JGzfq9Kzp2/64EQLUzFM+rdrUbuLRoACXyNuIQKheJfjIlyRDbEl6+WmP5QeTIhWmWfEjgg98PWyXMhl0FsUH9fRCUMbdgTTzu21LUiGRfL7xUmWVG8dEnLsOizx90R9rS066vbno9UhKZSpqAhg/58HxXQ0kC5/Ox4xW5z6/A0=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 05:43:08 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 05:43:08 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 20/22] drm/amd/pm: fix get dpm level count for smu13
Thread-Topic: [PATCH 20/22] drm/amd/pm: fix get dpm level count for smu13
Thread-Index: AQHaooVqX4IW2h2cK0aXL+yP8xvPa7GP9J+g
Date: Fri, 10 May 2024 05:43:07 +0000
Message-ID: <CY5PR12MB6369539F0AA6BC76A9B8D245C1E72@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-20-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-20-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4f433788-48c2-4439-9155-c76e489e9d79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:42:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: 8f854b7d-af8d-41d0-478e-08dc70b41214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?XnyhQ9KQZUuKTR7SyBSwCxihxU8uScuqdfPB1r/5lF67cLy78G+7o6OM4xFl?=
 =?us-ascii?Q?V66BizrmR6SGZJE34LCEXF1VrS0aK8TNVzwquZ7MstRM9IblSTlvKCemNr3D?=
 =?us-ascii?Q?k2wLh7Xdmq0xNfz4Gwss+NiWOz1Pjq6/43Gduz4gg3vPL4V4xLLMt+fG3Q1M?=
 =?us-ascii?Q?VOeUGDni8tLEkAkGOL7oUiF90DSgJPnRTXIlVNuaxxn1SXE++7lg2kQ9hyxU?=
 =?us-ascii?Q?VEfhnz/jYStX4EOigRYFb+kwq9k7O3BD9VPeKr35NdKfVdwA6BxgkYNgj36s?=
 =?us-ascii?Q?4OiI2C9XrwqSUycWjB1LUIXcSuGbaJiyplxcAmZwz3GgakraPhE196ZR+iKz?=
 =?us-ascii?Q?pJCG4/c5NgkXhYMKJDXRjVP4PPuMhxLTj25Lodl7HxcoHuyk629Cwav+2Mku?=
 =?us-ascii?Q?35mO6W8WRp5EemqLmWkF7xJrFgmKtCCl4SZefhE4IkPpSaKqO8ZQvEHIych2?=
 =?us-ascii?Q?Vbk65Q80msyAEw46mW9JuIsZBuTzWIXIVW+/VqG5EEbCyyRtL6xLdh0D7KIN?=
 =?us-ascii?Q?arZKLTT2BPq7wq64Nk2XxWIzVTRwHo8LtpEDz6VuLrq5m/XFWEp7O4/A3hnO?=
 =?us-ascii?Q?XP8nxCetWbRC1EZ3sYgRLqAdo5xHC0p2jXZnj+WA8N5VujL2uzwrjBuHp2W5?=
 =?us-ascii?Q?Hmi9EslDBxha3faAOLT2CR2T2VgIOkq3RuxTMIamdose8AynU9aa+XkNFD+C?=
 =?us-ascii?Q?CggHzh908wDYAtY11uhGg4vgpFgqDbuvQC6LT+CLm4f7e8C51BRYjJPy5j4F?=
 =?us-ascii?Q?JcM5ycBF+ZzOKztC2CPPoDuJ7ecfPamt4B7mlsUJFD+xk12Km0cxfo6kNcp5?=
 =?us-ascii?Q?L0RABbejV+XjohEABxYngj3UgwzR4kPrBiMUM7QMSdQf8i4tJ0eZ0lcTOlvi?=
 =?us-ascii?Q?xflGfAfv3Tq+XXa/ciyJRWSvuV5qfOjfjTH8rUmSxLzN54h6wVGXYRUKLHDe?=
 =?us-ascii?Q?PBiOLDY9DPTQJalki2DxTwVzvk2H6FWBK0GlvMTMi/flEjmnYOXTjdQILJHP?=
 =?us-ascii?Q?Fv5j3Nw5Sq2tbiP31RIuJcAo6BNHgxhfqGFlyQHZpgxo29yVaIOta5cwPzux?=
 =?us-ascii?Q?ga5uJyojP3yAy8BTKwEz7K+Kw74LLnm5Tn1py5nAYmqKNLIHVY9ajYfZ6cgE?=
 =?us-ascii?Q?0UNsSKZvVbauGE8wj0hDUK1ODy1TJr0RwsAGQKQ9whb8g01XdUVKNpt6CnCa?=
 =?us-ascii?Q?odWKjz8vQPSc5PM/uuJAmZJ25h4IQ/x/j1FuEmmISBdoaQPS92U5vvC4ehsV?=
 =?us-ascii?Q?twPvfRgcRf9tcZ5E8CD5SjdXiqEyjCOvyJsj7dkyjomfh9kKtMOOwx1ElzXB?=
 =?us-ascii?Q?I1CKn5B/khVo+5d8hvAtPYQSZ2K9IamjZDuNnLaSFZZN+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SsNLSWg9HYtHpfp95EYF5Y65EVgj5xjRXMahohBzToAcSkM56ghxJM8JgIY2?=
 =?us-ascii?Q?YH6TZ1yxq/IgiWZs21BMMlmdFrk/yrlKgTpaT8acGiJhjL3KdsSDUK2WNs2x?=
 =?us-ascii?Q?pLSbsEoRanUHyGee4uutSiz6yPBatdolg5rr6MXLeFRr2YmzTFi91DYM/gAj?=
 =?us-ascii?Q?ZAaVHGaRIf2D2Xe7XAvacitdUYPaPEpyWdSi0gSVaPP25MpfvFk7FoI0l/z2?=
 =?us-ascii?Q?APCY7lKpol73SG0JTBnjwO9gSgnfIdlR3Edbih/7Q7Nm7iM+82b9+dtb9QLM?=
 =?us-ascii?Q?aptUbMFMD5iDkvjs1iMPHe7jO40y0RBE3Xj4wfboauKBBLhM0W5LbaiZt8ox?=
 =?us-ascii?Q?st4Sei9p4gqf6/uFHV/DkyESbhXjXyACl02Vl1qOGbfzddu52mnKFMeiMIR7?=
 =?us-ascii?Q?jDZEaZGPEbZ0Z0XNFCphyXmDBflx9DaNdUs61hOANikvseNrIpD1ff5ocezN?=
 =?us-ascii?Q?0d3EM8lGt1xUZzX1brAK88NUb12IVTXxs2Kk+PgKAyo3bzitDA+yMGh8scW3?=
 =?us-ascii?Q?r5gtASC0rZ+mhXDLPWWb7UBeJ5o/97/rGEIaqrE2ocjdNtWmautI4ognItuQ?=
 =?us-ascii?Q?i60ZuAcceXZGbg1z3pr7PAQ5e6S7Ev47cR3fOwRzlFEXnVkvPXRuabPH57Qo?=
 =?us-ascii?Q?nFv5WNuPCWk406Npq17FWWekOLdIbbL+lWRqmYyKpE4a0Y6szY8m8XvXQp5f?=
 =?us-ascii?Q?ikPoB4ioGijofwnhxG7Rcrg0cVwDQDe5adlH397hkYjV4g5yyQww9jXGDUGS?=
 =?us-ascii?Q?FinsYiQloAWnlTxtu+ts9qvdZ0qoPany6RnEL2VPP9yu79OQY8IEsCYj+6nc?=
 =?us-ascii?Q?gV3750VkDDGPH6XZfOo84r2PvcsWj7YJmwu6zYZvbSb6OHpGpzA1M9JsW0NT?=
 =?us-ascii?Q?XyArVHZbJHhvIDXkOpjrap2oPpqoIZWQc0zQ4fb7wZDl0YdMrmtoi7oaeT3Y?=
 =?us-ascii?Q?jWde0mjb5qJfLcXpo17Kp/PUxKQpbpKg9ADn+HEtTazd4x7xkKS15Ej+wWjo?=
 =?us-ascii?Q?jcfVPB3CBBBR3ojs3GrR0ze/eLTJknGwNAO4SE81ydMmoiHROpFwqCRPwbAE?=
 =?us-ascii?Q?dTt/Pz41k6Zm+R9Mocsb5pd7WeKnrANlOwDAHzg7dNPTR1yoASYo7juZIz9E?=
 =?us-ascii?Q?+bBs7muf5rmVlmqalMMZXrJOaSiMLbLCAURCbjZmdOUfHCbTBJOyiiGAPlyd?=
 =?us-ascii?Q?n2e5P/292H4kGh7hJ/md/QA/ENES4Qbvn3oq1GL0GuZka4MA0QrXwbf8+Xjp?=
 =?us-ascii?Q?+bbddwSWuQTRJTL0yBgfpPaMEZVPcZTsSXvKopYY+B36VjbxWQm3gY/UrY+L?=
 =?us-ascii?Q?RJMDRLpaFtz2m78IEoc9Y8+LpHO4LTJU1UIvLCXVypwX33VHyWhECES+g4gj?=
 =?us-ascii?Q?rJC2uNRjLwe7ylS1SB8lQjSr0HolmXZTnxPnbae2s6odjVq3u4SqN/yIGnYz?=
 =?us-ascii?Q?i6iqK5v/zfHJy5yfIK9A2bKvakaVGLlTGF8V1ybdF6mXdp1m9NYWyMxDQXnp?=
 =?us-ascii?Q?b1o2JJaNIIxSROiKthwAQqLu2p4Jo6ZOUUFDrV0BsHBRzVl7J7WNLs2R7A?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f854b7d-af8d-41d0-478e-08dc70b41214
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 05:43:07.9345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lTYg8wYpgNw/tXk9tl91T218jb3e2m/FIDncXvF7SVsfrgBnf8iKSyK/mGO1OLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 20/22] drm/amd/pm: fix get dpm level count for smu13

For invalid clk types, return -EINVAL to check the return.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 59854465d711..9c2c43bfed0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -643,7 +643,7 @@ static int smu_v13_0_5_get_dpm_level_count(struct smu_c=
ontext *smu,
                *count =3D clk_table->NumDfPstatesEnabled;
                break;
        default:
-               break;
+               return -EINVAL;
        }

        return 0;
--
2.25.1

