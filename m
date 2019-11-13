Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EAC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1401C20409
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1401C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB926EDE4;
	Wed, 13 Nov 2019 18:29:21 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5576F6EDE4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 18:29:20 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADIT28o127090;
 Wed, 13 Nov 2019 18:29:18 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w5mvtxe9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 18:29:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADIT9W4052056;
 Wed, 13 Nov 2019 18:29:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2w7vbdb9px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 18:29:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADISt8m021455;
 Wed, 13 Nov 2019 18:28:57 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 10:28:55 -0800
Date: Wed, 13 Nov 2019 21:28:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: mikita.lipski@amd.com
Subject: [bug report] drm/amd/display: Add MST atomic routines
Message-ID: <20191113182849.7qzsh2odtr6dw2u3@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=692
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=754 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130158
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=TCUF2K2G1mzsRRtUAwn93OnLGJl3QF+lVocsAiiQpL4=;
 b=auW8hdjCCGkV39OMISWEPqpmfZUrBcYppZk7tVBSRGRenfnDyhNg4XblWjrvemg71KrP
 5hCuDp+WIMivsfwo/cj7owHFouh79OYK7R5rKX71v+OWiA8+k7fUSLoBIl5osBxANHZp
 ZlkqiYgS1/ZnPtB4WT0bCiXm1FcVndzVcVNLh2LTqsaKnBflx7uZDx7iudylClEXBsZe
 HjZY/+B6hlYtfVOs6rlFwkOgUxJaVJAVjB++Nbe8vEISfFMoWpWEHc9X/SiznBaSw2rr
 Ai3Bg8aPKlK4k+qZ3k1WnB0h6XdookujyVXUpjalSauBjPX/TTAz+UyfcRcIEe8JoCBu 5A== 
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113182849.bRtxIq2NC-9-tOYbP-eq8pdFPWKpbW8fk8WFjQoDL8A@z>

SGVsbG8gTWlraXRhIExpcHNraSwKClRoZSBwYXRjaCBiNGM1NzhmMDgzNzg6ICJkcm0vYW1kL2Rp
c3BsYXk6IEFkZCBNU1QgYXRvbWljIHJvdXRpbmVzIgpmcm9tIE5vdiA2LCAyMDE5LCBsZWFkcyB0
byB0aGUgZm9sbG93aW5nIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6CgoJZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6NDg3MCBkbV9lbmNv
ZGVyX2hlbHBlcl9hdG9taWNfY2hlY2soKQoJd2FybjogdW5zaWduZWQgJ2RtX25ld19jb25uZWN0
b3Jfc3RhdGUtPnZjcGlfc2xvdHMnIGlzIG5ldmVyIGxlc3MgdGhhbiB6ZXJvLgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKICA0ODUx
ICAgICAgICAgIGlmICghYWNvbm5lY3Rvci0+cG9ydCB8fCAhYWNvbm5lY3Rvci0+ZGNfc2luaykK
ICA0ODUyICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgNDg1MyAgCiAgNDg1NCAgICAgICAg
ICBtc3RfcG9ydCA9IGFjb25uZWN0b3ItPnBvcnQ7CiAgNDg1NSAgICAgICAgICBtc3RfbWdyID0g
JmFjb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyOwogIDQ4NTYgIAogIDQ4NTcgICAgICAgICAg
aWYgKCFjcnRjX3N0YXRlLT5jb25uZWN0b3JzX2NoYW5nZWQgJiYgIWNydGNfc3RhdGUtPm1vZGVf
Y2hhbmdlZCkKICA0ODU4ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgNDg1OSAgCiAgNDg2
MCAgICAgICAgICBpZiAoIXN0YXRlLT5kdXBsaWNhdGVkKSB7CiAgNDg2MSAgICAgICAgICAgICAg
ICAgIGNvbG9yX2RlcHRoID0gY29udmVydF9jb2xvcl9kZXB0aF9mcm9tX2Rpc3BsYXlfaW5mbyhj
b25uZWN0b3IsIGNvbm5fc3RhdGUpOwogIDQ4NjIgICAgICAgICAgICAgICAgICBicHAgPSBjb252
ZXJ0X2RjX2NvbG9yX2RlcHRoX2ludG9fYnBjKGNvbG9yX2RlcHRoKSAqIDM7CiAgNDg2MyAgICAg
ICAgICAgICAgICAgIGNsb2NrID0gYWRqdXN0ZWRfbW9kZS0+Y2xvY2s7CiAgNDg2NCAgICAgICAg
ICAgICAgICAgIGRtX25ld19jb25uZWN0b3Jfc3RhdGUtPnBibiA9IGRybV9kcF9jYWxjX3Bibl9t
b2RlKGNsb2NrLCBicHApOwogIDQ4NjUgICAgICAgICAgfQogIDQ4NjYgICAgICAgICAgZG1fbmV3
X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyA9IGRybV9kcF9hdG9taWNfZmluZF92Y3BpX3Ns
b3RzKHN0YXRlLAogIDQ4NjcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zdF9tZ3IsCiAgNDg2OCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbXN0X3BvcnQsCiAgNDg2OSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1fbmV3
X2Nvbm5lY3Rvcl9zdGF0ZS0+cGJuKTsKICA0ODcwICAgICAgICAgIGlmIChkbV9uZXdfY29ubmVj
dG9yX3N0YXRlLT52Y3BpX3Nsb3RzIDwgMCkgewogICAgICAgICAgICAgICAgICAgIF5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eCkltcG9zc2libGUgY29uZGl0aW9uLgoKICA0
ODcxICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHX0FUT01JQygiZmFpbGVkIGZpbmRpbmcgdmNw
aSBzbG90czogJWRcbiIsIChpbnQpZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyk7
CiAgNDg3MiAgICAgICAgICAgICAgICAgIHJldHVybiBkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52
Y3BpX3Nsb3RzOwogIDQ4NzMgICAgICAgICAgfQogIDQ4NzQgICAgICAgICAgcmV0dXJuIDA7CiAg
NDg3NSAgfQoKcmVnYXJkcywKZGFuIGNhcnBlbnRlcgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
